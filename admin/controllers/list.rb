SchaefflerWechat::Admin.controllers :list do
  get :articles, :provides => :json do
    @articles = Article.all.select([:id, :title, :name])
    @articles.to_json
  end

  get :images, :provides => :json do
    @images = Image.all.select([:id, :title, :href])
    @images.to_json
  end

end
