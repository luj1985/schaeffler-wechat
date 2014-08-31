SchaefflerWechat::App.controllers :menu do
  
  post :__preview do
    @menu = params[:menu]
    selected_articles = @menu[:selected_articles]
    selected_pages = @menu[:selected_pages]
    articles = Article.find selected_articles unless selected_articles.nil?
    pages = Page.find selected_pages unless selected_pages.nil?

    @articles = articles || []
    @pages = pages || []
    render :index
  end

  get :index, :with => :name do
    @menu = Menu.find_by_name params[:name]
    @articles = @menu.articles
    @pages = @menu.pages
    render :index
  end

end
