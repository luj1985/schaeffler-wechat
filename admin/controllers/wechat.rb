SchaefflerWechat::Admin.controllers :wechat do
  configure do
    set :access_token, nil
  end

  get :auto_reply do
    @auto_replies = AutoReply.all.paginate(:page => params[:page])
    render 'wechat/auto_reply'
  end

  # get :menu, :provides => :json do
  #   access_token = settings.access_token
  #   headers "Content-Type" => "application/json; charset=utf8"
  #   # if access_token.nil? then
  #     url = "#{ENV['WECHAT_BASE']}/token?grant_type=client_credential&appid=#{ENV['WECHAT_APPID']}&secret=#{ENV['WECHAT_SECRET']}"
  #     response = RestClient.get(url)
  #     payload = JSON.parse(response.body)
  #   	access_token = settings.access_token = payload["access_token"]
  # 	# end

  # 	url = "#{ENV['WECHAT_BASE']}/menu/get?access_token=#{access_token}"
  # 	response = RestClient.get(url)

  # 	response.body
  # end

  get :menu do
    render 'wechat/menu'
  end

  put :update do
  end
end