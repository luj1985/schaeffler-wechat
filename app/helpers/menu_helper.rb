SchaefflerWechat::App.helpers do

  def extract_cover_image article
    page = Nokogiri::HTML.fragment(article.body)
    img = page.css('img')[0]
    src = img ? img['src'] : '/images/no_image.jpg'
    "<img src=\"#{src}\" />"
  end

end
