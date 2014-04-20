SchaefflerWechat::App.controllers :activity do
  get :index, :with => :openid do
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
        @error = "This serial number has already been exchanged"
        render :error
      else
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

  end

end
