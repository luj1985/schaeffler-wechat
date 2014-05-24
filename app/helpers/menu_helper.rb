SchaefflerWechat::App.helpers do

  def extract_cover_image article
    page = Nokogiri::HTML.fragment(article.body)
    page.css('img')[0] || '<img src="/images/no_image.jpg" />'
  end

end
