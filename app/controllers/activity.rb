SchaefflerWechat::App.controllers :activity do
  get :index do
  	@page_id = "activity"
    openid = session[:openid] = params[:openid]
    render :index
  end

  post :challenge do
  	serial = params[:lottery][:serial]
  	crypted_serial = Digest::MD5::hexdigest serial
  	@lottery = Lottery.find_by_crypted_serial crypted_serial
    if @lottery then
      if not @lottery.available? then
        @error = t('activity.result.used')
        render :error
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
      render :thanks
    end
  end

  post :save do
    @lottery = Lottery.find_by_id(params[:id])
    halt 404 unless @lottery
    @lottery.status = 'USED'
    if @lottery.update(params[:lottery])
      redirect url(:activity, :index)
    else
      render :profile
    end
  end
end
