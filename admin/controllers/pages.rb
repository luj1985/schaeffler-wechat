SchaefflerWechat::Admin.controllers :pages do
  get :index do
    @title = "Pages"
    @pages = Page.all
    render 'pages/index'
  end
end
