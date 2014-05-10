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

  get :index do
    render :index
  end

  get :rules do
    render :rules
  end

  get :questions do
    @questions = Question.order('random()').limit(2)
    render :questions
  end

  # get :others, :map => '/activity/*' do
  #   redirect url(:activity, :index)
  # end

  post :apply do
    misses = params.reject do |id, value|
      question = Question.find_by_id id
      return false unless question
      question.correct == value
    end
    openid = session[:openid]
    user = User.find_by_openid openid
    halt 500 unless user

    if user.apply_attemped then
      @message = t('activity.apply.attempted')
      return render :message
    end

    passed = (params.length == 2) && misses.empty?
    user.apply_attemped = true
    user.join_match = passed
    user.save
    @message = passed ? t('activity.question.pass') : t('activity.question.fail')
    render :message
  end

  post :confirm do
  	raw = params[:lottery][:serial]
    serial = raw.scan(/\d/).join('')
  	crypted_serial = Digest::MD5::hexdigest serial
  	@lottery = Lottery.find_by_crypted_serial crypted_serial
    if @lottery then
      if not @lottery.available? then
        @message = <<EOF
<p class="message">对不起，您输入的验证码已经被兑换。</p>
<p>如有问题，您可拨打活动专线咨询：
<a href="tel:021-39576702">021-39576702</a>
</p>
EOF
        render :message
      else
        @lottery.status = 'EXCHANGING'
        # TODO: should redirect page if open id is not defined
        openid = session[:openid]
        user = User.find_or_initialize_by :openid => openid
        @lottery.user = user
        @lottery.serial = serial
        render :confirm
      end
    else
      @message = <<EOF
<p class="message">对不起，您输入的验证码有误，请检查您的输入。</p>
<p>如有问题，您可拨打活动专线咨询：
<a href="tel:021-39576702">021-39576702</a>
</p>
EOF
      render :message
    end
  end

  post :save do
    @lottery = Lottery.find_by_id(params[:id])
    halt 404 unless @lottery
    @lottery.status = 'USED'
    if @lottery.update(params[:lottery])
      @message = @lottery.level == '4' ? 
        t('activity.result.success4')  : 
        t('activity.result.success')
      render :message
    else
      render :confirm
    end
  end



  configure :development do
    # for view layout debug only
    get :challenge, :with => :debug, :protect => false do
      @lottery = Lottery.find_by_id 1
      render :confirm
    end
  end
end
