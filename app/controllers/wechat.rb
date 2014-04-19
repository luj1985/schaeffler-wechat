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

  post :index do
    content_type :xml
    doc = Crack::XML.parse(request.body.read)
    hash = doc["xml"]
    type = hash["MsgType"]
    event = hash["Event"] || ""
    if hash["MsgType"] == "event" and event.downcase == "click" then
      openid = hash["FromUserName"]
      key = hash["EventKey"]
    end
    openid || ""
  end
end
