SchaefflerWechat::App.controllers :menu do
  
  get :index, :with => :name do
    @article = Article.find_by_name params[:name]
    render :menu
  end

end