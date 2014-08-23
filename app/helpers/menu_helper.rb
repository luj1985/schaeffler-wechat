SchaefflerWechat::App.helpers do

  def extract_cover_image article
    src = if article.image then
      article.image
    else
      el = Nokogiri::HTML.fragment(article.body).css('img')[0]
      el ? el['src'] : '/images/no_image.jpg'
    end
    "<img src=\"#{src}\" />"
  end

end
