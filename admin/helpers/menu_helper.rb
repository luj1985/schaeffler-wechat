SchaefflerWechat::Admin.helpers do

  def dropdown_selection menu
    selected = menu.articles.map { |article| article.id }
    articles = Article.select(:id, :title).all
      .order(:title).reject { |article| selected.include?(article.id) }
    articles.map { |article| [article.title, article.id] }
  end

end
