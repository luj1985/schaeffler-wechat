SchaefflerWechat::App.controllers :wechat do
  configure do
    set :event_handlers, {}
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
    case type
    when :event
      event = hash[:event].downcase.to_sym
      handlers = event_handlers[event] || []
      handler = handlers.find { |h| h[:condition].call(hash) }
      halt 501, "no handler defined" if handler.nil?
      instance_exec hash, &handler[:proc]
    else
      halt 501, "unknown event type #{type}"
    end
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
            xml.Title '“买舍弗勒产品，刮好礼，享速度与激情”\n活动兑换'
            xml.Description '本次活动仅限修理厂用户参与'
            xml.PicUrl URI.join(host, '/images/exchange-poster.jpg')
            xml.Url URI.join(host, url_for(:activity, :index, :openid => hash[:from_user_name]))
          }
        }
      }
    end
    builder.to_xml
  end

end
