SchaefflerWechat::App.controllers :activity do
  get :intro do
    render :intro
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
        @lottery.serial = serial
        # TODO: should redirect page if open id is not defined
        openid = session[:openid]
        user = User.find_by_openid openid
        user = User.new(:openid => openid) if user.nil?
        # TODO: access session for openid
        @lottery.user = user
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
      @message = t('activity.result.success')
      render :message
    else
      render :profile
    end
  end
end
