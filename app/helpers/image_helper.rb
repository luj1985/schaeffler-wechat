SchaefflerWechat::App.helpers do

  def cropped_image article, width=640
    return article[:image] unless article[:offset]

    basename = File.basename(article[:image], ".*")
    extension = File.extname(article[:image])
    offset = JSON.parse(article[:offset])

    x1,y1,x2,y2,w,h = offset.values_at("x", "y", "x2", "y2", "w", "h")

    original = File.join("public", article[:image])
    name = "#{basename}-#{x1.round}-#{y1.round}-#{x2.round}-#{y2.round}#{extension}"
    
    target = File.join("public/uploads", name)
    link =  "/uploads/#{name}"

    if not File.exists?(target) then
      img = Magick::Image.read(original).first
      img.crop!(x1, y1, w, h)
      output_width = w > width ? width : w
      img.resize!(output_width, output_width * (h / w))
      img.write(target)
    end
    link
  end

  def extract_cover_image article
    if article[:image] then
      cropped_image article
    else
      el = Nokogiri::HTML.fragment(article[:body]).css('img')[0]
      el ? el['src'] : '/images/no_image.jpg'
    end
  end
end
