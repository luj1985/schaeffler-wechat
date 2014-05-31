SchaefflerWechat::Admin.controllers :wmenus do
  configure do
    set :access_token, nil
  end

  get :wechat, :provides => :json do
    access_token = settings.access_token
    headers "Content-Type" => "application/json; charset=utf8"
    if access_token.nil? then
      url = "#{ENV['WECHAT_BASE']}/token?grant_type=client_credential&appid=#{ENV['WECHAT_APPID']}&secret=#{ENV['WECHAT_SECRET']}"
      response = RestClient.get(url)
      payload = JSON.parse(response.body)
    	access_token = settings.access_token = payload["access_token"]
  	end

  	url = "#{ENV['WECHAT_BASE']}/menu/get?access_token=#{access_token}"
  	response = RestClient.get(url)

  	response.body
  end

  get :index do
  	render 'wechat/index'
  end
end