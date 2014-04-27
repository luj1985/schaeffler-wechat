SchaefflerWechat::App.controllers :wechat do
  configure do
    set :event_handlers, {}
  end

  def wechat_event event, condition = nil, &blk
    event_handlers = settings.event_handlers
    event_handlers[event] ||= Array.new
    task = {:proc => blk}
    task.merge!(:condition => lambda {|hash|
      condition.all? { |k, v| condition[k] == v }
    }) if condition.present?
    event_handlers[event] << task
  end


  get :index do
    token = ENV["WECHAT_TOKEN"] || 'test'
    raw = [token, params[:timestamp], params[:nonce]].compact.sort.join
    Digest::SHA1.hexdigest(raw) == params[:signature] ? params[:echostr] : ""
  end

  post :index do
    event_handlers = settings.event_handlers
    body = request.body.read || ""
    # TODO validate post message signature
    halt 501, "unknown post body" if body.empty?

    doc = Nokogiri::XML(body).root
    hash = doc.element_children.each_with_object(Hash.new) do |e, h|
      name = e.name.gsub(/(.)([A-Z])/,'\1_\2').downcase
      h[name.to_sym] = e.content
    end
    type = hash[:msg_type].downcase.to_sym
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


  wechat_event :click, :event_key => 'activity' do |hash|
    content_type :xml
    host = ENV['WECHAT_HOST']
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      xml.xml {
        xml.ToUserName hash[:from_user_name]
        xml.FromUserName hash[:to_user_name]
        xml.CreateTime Time.now.to_i
        xml.MsgType "news"
        xml.ArticleCount 2
        xml.Articles {
          xml.item {
            xml.Title t('activity.intro.title')
            xml.Description t('activity.intro.description')
            xml.PicUrl URI.join(host, '/images/introduction.jpg')
            xml.Url URI.join(host, url_for(:activity, :intro, :openid => hash[:from_user_name]))
          }
          xml.item {
            xml.Title t('activity.entry.title')
            xml.Description t('activity.entry.description')
            xml.PicUrl URI.join(host, '/images/innovation_intro_header.jpg')
            xml.Url URI.join(host, url_for(:activity, :index, :openid => hash[:from_user_name]))
          }
        }
      }
    end
    builder.to_xml
  end

end
