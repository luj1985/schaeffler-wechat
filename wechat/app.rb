module SchaefflerWechat
  class Wechat < Padrino::Application
    require 'sinatra/wechat'

    register Sinatra::Wechat
    use Rack::Env
    enable :sessions

    def execute_reply replies, values
      return "" if replies.length == 0
      
      rtype = replies.first.rtype
      valid_replies = replies.select { |reply| reply.rtype == rtype }

      if rtype == 'news' then
        wechat_news_reply valid_replies, values
      elsif rtype == 'text'
        wechat_text_reply valid_replies, values 
      end
    end

    # for 'text' type reply, only one action can be execute at the same time
    def wechat_text_reply replies, values
      content_type :xml
      values[:host] = ENV['WECHAT_HOST']

      reply = replies[0]

      if not reply.nil? then
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.xml {
            xml.ToUserName values[:from_user_name]
            xml.FromUserName values[:to_user_name]
            xml.CreateTime Time.now.to_i
            xml.MsgType "text"
            xml.Content reply.description % values
          }
        end
        builder.to_xml
      else
        ""
      end
    end

    # for 'news' type reply, serveral response can be take at the same time
    def wechat_news_reply replies, values
      content_type :xml
      values[:host] = ENV['WECHAT_HOST']
      
      if replies.length != 0 then
        builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
          xml.xml {
            xml.ToUserName values[:from_user_name]
            xml.FromUserName values[:to_user_name]
            xml.CreateTime Time.now.to_i
            xml.MsgType "news"
            xml.ArticleCount replies.length
            xml.Articles {
              replies.each do |reply|
                xml.item {
                  xml.Title reply.title % values
                  xml.Description reply.description % values
                  xml.PicUrl reply.pic_url % values
                  xml.Url reply.url % values
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

    wechat('/', :wechat_token => ENV["WECHAT_TOKEN"] || 'test', ) {
      text {
        content_type :xml
        values = request[:wechat_values]
        replies = AutoReply.where(:event => 'keyword').order(:weight => :desc)
        content = values[:content] || ""
        reply = replies.find { |reply| content.include? reply.param }
        execute_reply [reply], values
      }
      event(:event => 'click', :event_key => 'activity') {
        content_type :xml
        values = request[:wechat_values]
        replies = AutoReply.where :event => 'click', :param => 'activity'
        execute_reply replies, values
      }
      event(:event => 'subscribe') {
        content_type :xml
        values = request[:wechat_values]
        replies = AutoReply.where :event => 'subscribe'
        execute_reply replies, values
      }
    }
  end
end
