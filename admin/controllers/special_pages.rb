SchaefflerWechat::Admin.controllers :special_pages do
  get :index do
    @title = "Special_pages"
    @pages = SpecialPage.all
    render 'special_pages/index'
  end
end
