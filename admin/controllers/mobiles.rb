SchaefflerWechat::Admin.controllers :mobiles do
  get :index do
    @title = "App推广"
    @mobiles = Mobile.all
    render 'mobiles'
  end
end