SchaefflerWechat::Admin.controllers :pages do
  get :index do
    @title = "Pages"
    @pages = Page.all.paginate(:page => params[:page])
    render 'pages'
  end
end
