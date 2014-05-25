SchaefflerWechat::Admin.helpers do

  def dropdown_articles menu
    selected = menu.articles.map { |article| article.id }
    articles = Article.select(:id, :title).all
      .order(:title).reject { |article| selected.include?(article.id) }
    articles.map { |article| [article.title, article.id] }
  end

  def dropdown_pages menu
  	selected = menu.pages.map { |page| page.id }
  	pages = Page.select(:id, :title).all
  		.order(:title).reject { |page| selected.include?(page.id) }
  	pages.map { |page| [page.title, page.id]}
  end
end
