SchaefflerWechat::Admin.controllers :wechat do
  configure do
    appid = ENV['WECHAT_APPID']
    secret = ENV['WECHAT_SECRET']
    base = ENV['WECHAT_BASE']
    set :wechat_api, Wechat::Adapter::WechatAPI.new(appid, secret, base)
  end

  post :index do
    menu = params["menu_contents"]
    @json_menu = JSON.parse(menu)
    wechat_api = settings.wechat_api
    wechat_api.get 'menu/delete'
    wechat_api.post 'menu/create', {}, @json_menu
    render 'wechat/index'
  end

  get :index do
    wechat_api = settings.wechat_api
    raw_json = wechat_api.get 'menu/get'
    @json_menu = raw_json["menu"]
    render 'wechat/index'
  end

  put :update do
  end
end