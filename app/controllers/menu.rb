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

  post :__previewarticle do
    @article = params[:article]
    menus = @article[:menus]

    if menus && menus.length > 0 then
      @menu = Menu.find_by_id menus[0]
    else
      @menu = Menu.new
    end

    @articles = [@article]
    @pages = []
    render :index
  end

  get :index, :with => :name do
    @menu = Menu.find_by_name params[:name]
    @articles = @menu.articles
    @pages = @menu.pages
    render :index
  end

end
