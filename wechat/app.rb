module SchaefflerWechat
  class Wechat < Padrino::Application
    register Padrino::Helpers
    
    use Rack::Env
    enable :sessions

    configure do
      set :event_handlers, {}
      set :message_handlers, {}
    end

    class << self
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

    # used for keyword auto reply
    message_event :text do |hash|
      content_type :xml

      replies = AutoReply.where(:event => 'keyword').order(:weight => :desc)

      content = hash[:content] || ""
      reply = replies.find { |reply| content.include? reply.param }

      execute_reply [reply], hash
    end

    def execute_reply replies, hash
      return "" if replies.length == 0
      
      rtype = replies.first.rtype
      valid_replies = replies.select { |reply| reply.rtype == rtype }

      if rtype == 'news' then
        wechat_news_reply valid_replies, hash
      elsif rtype == 'text'
        wechat_text_reply valid_replies, hash 
      end
    end

    # for 'text' type reply, only one action can be execute at the same time
    def wechat_text_reply replies, hash
      content_type :xml
      hash[:host] = ENV['WECHAT_HOST']

      reply = replies[0]

      if not reply.nil? then
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.xml {
            xml.ToUserName hash[:from_user_name]
            xml.FromUserName hash[:to_user_name]
            xml.CreateTime Time.now.to_i
            xml.MsgType "text"
            xml.Content reply.description % hash
          }
        end
        builder.to_xml
      else
        ""
      end
    end

    # for 'news' type reply, serveral response can be take at the same time
    def wechat_news_reply replies, hash
      content_type :xml
      hash[:host] = ENV['WECHAT_HOST']
      
      if replies.length != 0 then
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.xml {
            xml.ToUserName hash[:from_user_name]
            xml.FromUserName hash[:to_user_name]
            xml.CreateTime Time.now.to_i
            xml.MsgType "news"
            xml.ArticleCount replies.length
            xml.Articles {
              replies.each do |reply|
                xml.item {
                  xml.Title reply.title % hash
                  xml.Description reply.description % hash
                  xml.PicUrl reply.pic_url % hash
                  xml.Url reply.url % hash
                }
              end
            }
          }
        end
        builder.to_xml
      else
        ""
      end
    end
    
    wechat_event :click, :event_key => 'activity' do |hash|
      replies = AutoReply.where :event => 'click', :param => 'activity'
      execute_reply replies, hash
    end
    
    wechat_event :subscribe do |hash|
      replies = AutoReply.where :event => 'subscribe'
      execute_reply replies, hash
    end
  end
end
