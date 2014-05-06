SchaefflerWechat::App.controllers :activity do
  get :intro do
    render :intro
  end

  # This is used for debug layout, should remove it later
  get :challenge, :with => :debug do
    @lottery = Lottery.find_by_id 1
    render :profile
  end

  get :rules do
    render :rules
  end

  get :index do
    if params[:openid].present? then
      session[:openid] = params[:openid]
    end
    if session[:openid].nil? then
      @message = t('activity.result.invalid.openid')
      render :message
    else 
      render :index
    end
  end

  get :questions do
    openid = session[:openid]
    @questions = Question.order('random()').limit(2)
    render :apply
  end

  get :others, :map => '/activity/*' do
    redirect url(:activity, :index)
  end

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

    passed = !params.empty? && misses.empty?
    user.apply_attemped = true
    user.join_match = passed
    user.save
    @message = passed ? t('activity.question.pass') : t('activity.question.fail')
    render :message
  end

  post :challenge do
  	serial = params[:lottery][:serial]
  	crypted_serial = Digest::MD5::hexdigest serial
  	@lottery = Lottery.find_by_crypted_serial crypted_serial
    if @lottery then
      if not @lottery.available? then
        @message = t('activity.result.used')
        render :message
      else
        @lottery.status = 'EXCHANGING'
        # TODO: should redirect page if open id is not defined
        openid = session[:openid]
        user = User.find_or_initialize_by :openid => openid
        @lottery.user = user
        @lottery.serial = serial
        render :profile
      end
    else
      @message = t('activity.result.missing')
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
      render :profile
    end
  end
end
