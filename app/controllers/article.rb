SchaefflerWechat::App.controllers :article do
  
  get :index, :with => :name do
    @article = Article.find_by_name params[:name]
    render :article
  end

  get :menu do
    @menu = Article.find_by_name params[:name]
    render :menu
  end

end
