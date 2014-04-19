module Wechat
  module Events
    class << self
      def registered app
        event_handlers = Hash.new

        app.get :index do
          token = ENV["WECHAT_TOKEN"] || 'test'
          raw = [token, params[:timestamp], params[:nonce]].compact.sort.join
          echostr = Digest::SHA1.hexdigest(raw) == params[:signature] ? params[:echostr] : ""

          puts "echo string is #{echostr}"
          
          echostr
        end

        app.post :index do
          content_type :xml

          puts request.body.read

          dom = Nokogiri::XML(request.body.read)
          hash = dom.root.element_children.each_with_object(Hash.new) do |e, h|
            name = e.name.gsub(/(.)([A-Z])/,'\1_\2').downcase
            h[name.to_sym] = e.content
          end
          type = hash[:msg_type].to_sym
          case type
          when :event
            event = hash[:event].to_sym
            handlers = event_handlers[event] || []
            handler = handlers.find do |handler|
              handler[:condition].call(hash)
            end
            response = handler[:proc].call(hash)

            puts response

            response
          else
            halt 501, "Cannot handle this kind of message #{type}"
          end
        end

        controller = class << app; self; end
        controller.instance_eval do
          # TODO: add other message type
          define_method :wechat_event do |event, condition = nil, &blk|
            event_handlers[event] ||= Array.new
            task = {:proc => blk}
            task.merge!(:condition => lambda {|hash|
              condition.all? { |k, v| condition[k] == v }
            }) if condition.present?
            event_handlers[event] << task
          end
        end
      end
      alias :included :registered
    end
  end
end
