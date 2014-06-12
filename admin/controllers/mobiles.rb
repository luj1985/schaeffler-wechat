SchaefflerWechat::Admin.controllers :mobiles do
  get :index do
  	@title = "App"
    @mobiles = Mobile.all
    render 'mobiles/index'
  end
end