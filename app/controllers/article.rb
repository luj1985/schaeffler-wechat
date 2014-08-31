SchaefflerWechat::App.controllers :article do
  
  get :index, :with => :name do
    @article = Article.find_by_name params[:name]
    halt 404 unless @article
    render :index
  end

  post :__preview do
    @article = params[:article]
    render :index
  end
end
