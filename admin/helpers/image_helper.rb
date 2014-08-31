SchaefflerWechat::Admin.helpers do

  def image_size menu
    return [] unless menu.image
    path = File.join("public", menu.image)
    if File.exists?(path) && File.file?(path) then
      img = Magick::Image.read(path).first
      return [img.columns, img.rows]
    end
    return []
  end
end