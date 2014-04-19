SchaefflerWechat::App.controllers :wechat do  
  get :index do
    signature = params[:signature]
    timestamp = params[:timestamp]
    nonce = params[:nonce]

    token = ENV["token"] || 'test'

    raw = [token, timestamp, nonce].compact.sort.join
    hash = Digest::SHA1.hexdigest(raw)

    hash == signature ? params[:echostr] : ""
  end
end
