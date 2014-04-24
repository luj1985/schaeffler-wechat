SchaefflerWechat::App.controllers :article do
  
  get :index, :with => :name do
    @article = Article.find_by_name params[:name]
    render :index
  end

end
