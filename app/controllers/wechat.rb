SchaefflerWechat::App.controllers :wechat do
  configure do
    set :event_handlers, {}
    set :message_handlers, {}
  end

  get :index do
    validate_messages ? params[:echostr] : ""
  end

  post :index do
    halt 403 unless validate_messages

    body = request.body.read || ""
    halt 501 if body.empty?

    doc = Nokogiri::XML(body).root
    hash = doc.element_children.each_with_object(Hash.new) do |e, h|
      name = e.name.gsub(/(.)([A-Z])/,'\1_\2').downcase
      h[name.to_sym] = e.content
    end

    type = hash[:msg_type].downcase.to_sym
    event_handlers = settings.event_handlers
    if type == :event then
      event = hash[:event].downcase.to_sym
      handlers = event_handlers[event] || []
      handler = handlers.find { |h| h[:condition].call(hash) }
      halt 501, "no handler defined" if handler.nil?
      instance_exec hash, &handler[:proc]
    elsif [:text, :image, :voice, :video, :location, :link].include?(type)
      message_handlers = settings.message_handlers
      handler = message_handlers[type]
      halt 501, "no handler defined" if handler.nil?
      instance_exec hash, &handler
    else
      halt 501, "unknown message type #{type}"
    end
  end
  
  def message_event type, &blk
    message_handlers = settings.message_handlers
    message_handlers[type] = blk
  end

  def wechat_event event, condition = nil, &blk
    event_handlers = settings.event_handlers
    event_handlers[event] ||= []
    # when condition not defined, alwasy return true
    task = {:proc => blk, :condition => lambda {|h| true} }
    task.merge!(:condition => lambda {|hash|
      condition.all? { |k, v| condition[k] == v }
    }) if condition.present?
    event_handlers[event] << task
  end
  
  message_event :text do |hash|
    content_type :xml
    content = hash[:content] || ""

    message = ""
    if content.include? '申请海报' then
      message = "您的海报申请信息我们已经收到，我们将尽快安排活动海报出发，请您注意查收，谢谢"
    end
    
    if content.include? '省' or content.include? '市' then
      message = "感谢您参与本次活动，请确认提交的联系方式准确无误，以便我们联系您"
    end
    
    if !message.empty? then
      builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
        xml.xml {
          xml.ToUserName hash[:from_user_name]
          xml.FromUserName hash[:to_user_name]
          xml.CreateTime Time.now.to_i
          xml.MsgType "text"
          xml.Content message
        }
      end
      builder.to_xml
    else
      ""
    end
  end

  wechat_event :click, :event_key => 'activity' do |hash|
    content_type :xml
    host = ENV['WECHAT_HOST']
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.xml {
        xml.ToUserName hash[:from_user_name]
        xml.FromUserName hash[:to_user_name]
        xml.CreateTime Time.now.to_i
        xml.MsgType "news"
        xml.ArticleCount 1
        xml.Articles {
          xml.item {
            xml.Title "“买舍弗勒产品，刮好礼，享速度与激情”"
            xml.Description ''
            xml.PicUrl URI.join(host, '/images/activity/push-message.png')
            xml.Url URI.join(host, url_for(:activity, :index, :openid => hash[:from_user_name]))
          }
        }
      }
    end
    builder.to_xml
  end

  wechat_event :subscribe do |hash|
    content_type :xml
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.xml {
        xml.ToUserName hash[:from_user_name]
        xml.FromUserName hash[:to_user_name]
        xml.CreateTime Time.now.to_i
        xml.MsgType "text"
        xml.Content "欢迎您关注舍弗勒中国汽车售后。
即日起至12月31日，购买舍弗勒LuK、INA、FAG赛事促销装产品，即有机会赢得新一代 iPhone 手机，及其他好礼。

更多详情，请点击“促销活动”。"
      }
    end
    builder.to_xml
  end

end
