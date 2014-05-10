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



  post :confirm do
    raw = params[:lottery][:serial]
    serial = raw.scan(/\d/).join('')
    @lottery = Lottery.challenge serial
    if @lottery then # correct serial number
      if @lottery.available? then
        @lottery.status = 'EXCHANGING'
        user = User.find_or_initialize_by :openid => session[:openid]
        @lottery.user = user
        @lottery.serial = serial
        render :confirm
      else
        @message = <<EOF
<p class="message">您所输入的兑奖验证码已经被兑换。请您检查是否验证码输入有误。</p>
<p>如有问题，请拨打活动热线：<a href="tel:021-39576702">021-39576702</a></p>
EOF
        render :message
      end
    else
      @message = <<EOF
<p class="message">您输入的验证码有误，请您检查并重新输入。</p>
<p>如有问题，请拨打活动热线：<a href="tel:021-39576702">021-39576702</a></p>
EOF
      render :message
    end
  end



  post :save do
    @lottery = Lottery.find_by_id(params[:id])
    halt 404 unless @lottery
    @lottery.status = 'USED'
    if @lottery.update(params[:lottery])
      render :success
    else
      render :confirm
    end
  end




  get :rules do
    render :rules
  end




  get :questions do
    @questions = Question.order('random()').limit(2)
    render :questions
  end



  post :apply do
    misses = params.reject do |id, value|
      question = Question.find_by_id id
      return false unless question
      question.correct == value
    end
    user = User.find_by_openid session[:openid]
    halt 500, "没有找您的微信账户" unless user

    if user.apply_attemped then
      @message = '不能多次申请观赛'
      return render :message
    end

    passed = (params.length == 2) && misses.empty?
    user.apply_attemped = true
    user.join_match = passed
    user.save
    msg_passed = <<EOF
<p class="message">恭喜您回答正确！</p>
<p class="message">
您获得了申请现场观赛的资格，我们将于8月初和10月初
从回答正确的申请者中抽取出幸运者！获得现场激情观赛的机会哦！</p>
<p class="message">届时请您关注舍弗勒汽车售后微信公共帐号！</p>
EOF
    msg_fail = <<EOF
<p class="message">非常抱歉，您提交的答案不正确！
<img src="/images/cry.gif" style="height:50px;width:50px"/>
</p>
<p class="message">预祝您能刮中更多奖品哦！</p>
EOF
    @message = passed ? msg_passed : msg_fail
    render :message
  end




  # get :others, :map => '/activity/*' do
  #   redirect url(:activity, :index)
  # end



  configure :development do
    # for view layout debug only
    get :challenge, :with => :debug, :protect => false do
      @lottery = Lottery.find_by_id 1
      render :confirm
    end
  end
end
