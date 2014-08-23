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
    status 200
  end

  upload = lambda do
    path = params[:path]

    tempfile = params[:file][:tempfile]
    filename = params[:file][:filename]
    extension = File.extname(filename)
    resource = SecureRandom.hex + extension
    target = "public/uploads/#{resource}"
    link =  "/uploads/#{resource}"

    link = ENV['WECHAT_ENDPOINT'] + link if path == 'absolute'   

    cp tempfile.path, target
    chmod 0644, target # otherwise it cannot be read by nginx

    Image.create :title => filename, :href => link
    { :link => link }.to_json
  end

  post :upload, &upload
  put :upload, &upload
end
