SchaefflerWechat::App.controllers :activity do
  get :index, :with => :openid do
    openid = session[:openid] = params[:openid]
    render :index
  end

  post :challenge do

  end

  post :save do

  end

end
