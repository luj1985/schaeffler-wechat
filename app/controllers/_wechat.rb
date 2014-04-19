module Wechat
  module Events
    class << self
      def registered app
        handler = Hash.new

        app.get :index do
          token = ENV["WECHAT_TOKEN"] || 'test'
          raw = [token, params[:timestamp], params[:nonce]].compact.sort.join
          Digest::SHA1.hexdigest(raw) == params[:signature] ? params[:echostr] : ""
        end

        app.post :index do
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

        metaclass = class << app; self; end

        metaclass.instance_eval do
          define_method :wechat do |event, with = nil, &blk|
            puts "event is #{event}"
            puts "with is #{with}"
          end
        end
      end
      alias :included :registered
    end
  end
end
