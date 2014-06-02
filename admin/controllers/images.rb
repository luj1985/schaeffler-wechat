SchaefflerWechat::Admin.controllers :images do
  include FileUtils
  require 'securerandom'

  get :list do
    @urls = Image.all.collect {|i| i.href }
    @urls.to_json.to_s
  end

  post :delete do
    src = params[:src]
    Image.destroy_all(:href => src)
  end

  upload = lambda do
    tempfile = params[:file][:tempfile]
    filename = params[:file][:filename]
    extension = File.extname(filename)
    resource = SecureRandom.hex + extension;
    target = "public/uploads/#{resource}"
    link =  "/uploads/#{resource}"

    cp tempfile.path, target
    chmod 0644, target

    Image.create :title => filename, :href => link

    res = {
      :link => link
    }
    res.to_json
  end

  post :upload, &upload
  put :upload, &upload
end
