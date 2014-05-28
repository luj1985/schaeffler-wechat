SchaefflerWechat::App.controllers :activity, :conditions => {:protect => true} do
  def self.protect(protected)
    condition do
      if params[:openid].present? then
        session[:openid] = params[:openid]
      end
      halt 403, "缺少OpenID，请点击菜单按钮访问" if session[:openid].nil?
    end if protected
  end

  get :intro, :protect => false do
    render :intro
  end

  get :intro1, :protect => false do
    render :intro1
  end

  get :progress, :protect => false do
    render :progress
  end


  get :index do
    render :index
  end



  post :confirm do
    user = User.find_or_initialize_by :openid => session[:openid]
    halt 403, "对不起，您的账户已经被被禁用" if user.blocked

    # initialize rules
    session[:failCount] = session[:failCount] || 0
    session[:successCount] = session[:successCount] || 0
    lasttime = session[:last_challenge_time] || Time.now
    if (Time.now.strftime '%Y%m%d') == (lasttime.strftime '%Y%m%d') then
      halt 403, "您当天已经累计输入错误3次，今天您将无法再提交验证码，请您明天再尝试兑奖。感谢您的理解和配合。" if session[:failCount] >= 3
      halt 403, "您好，感谢您的积极参与。您当天的累计兑奖数已达到上限20个，您可第二天继续来完成兑奖，感谢您的理解和配合。" if session[:successCount] >= 20
    else
      session[:failCount] = 0
      session[:successCount] = 0
    end
    session[:last_challenge_time] = Time.now

    serial = params[:lottery][:serial]


    @lottery = Lottery.challenge serial
     # record found, correct serial number
    if @lottery && @lottery.available?then
      @lottery.status = 'EXCHANGING'
      @lottery.user = user
      @lottery.serial = serial
      render :confirm
    else
      if not @lottery then
        # same day
        if (Time.now.strftime '%Y%m%d') == (lasttime.strftime '%Y%m%d') then
          session[:failCount] += 1
        end
      end
      render :fail
    end
  end



  post :save do
    @lottery = Lottery.find_by_id(params[:id])
    halt 404, "无效的验证码" unless @lottery
    @lottery.status = 'USED'
    @lottery.exchange_time = Time.now
    if @lottery.update(params[:lottery])
      @lottery.user.update_permission

      lasttime = session[:last_challenge_time] || Time.now
      session[:successCount] = session[:successCount] || 0
      # same day
      if (Time.now.strftime '%Y%m%d') == (lasttime.strftime '%Y%m%d') then
        session[:successCount] += 1
      end

      render :success
    else
      render :confirm
    end
  end




  get :rules do
    render :rules
  end




  get :questions do
    user = User.find_by_openid session[:openid]
    if user.apply_attemped then
      redirect url(:activity, :index)
    else
      @questions = Question.order('random()').limit(2)
      render :questions
    end
  end



  post :apply do
    user = User.find_by_openid session[:openid]
    halt 409, "无效的微信账户" unless user
    halt 409, '不能多次申请观赛' if user.apply_attemped

    misses = params.reject do |id, value|
      question = Question.find_by_id id
      question && question.correct == value
    end

    @passed = (params.length == 2) && misses.empty?
    user.apply_attemped = true
    user.join_match = @passed
    user.apply_time = Time.now
    user.save
    render :answer
  end


  configure :development do
    # for view layout debug only
    get :challenge, :with => :debug, :protect => false do
      @lottery = Lottery.find_by_id 1
      render :confirm
    end


    get :fail do
      @passed = false
      render :answer
    end

    get :success do
      @lottery = Lottery.find_by_id 1
      @lottery.can_apply_join_match?
      render :success
    end
  end


  get :others, :map => '/activity/*' do
    redirect url(:activity, :index)
  end

end
