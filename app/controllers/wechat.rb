require '_wechat'

SchaefflerWechat::App.controllers :wechat do
  register Wechat::Events

  wechat_event :click, :event_key => 'activity' do |hash|
    host = ENV['WECHAT_HOST']
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.xml {
        xml.ToUserName hash[:from_user_name]
        xml.FromUserName hash[:to_user_name]
        xml.CreateTime Time.now.to_i
        xml.MsgType "news"
        xml.ArticleCount 2
        xml.Articles {
          xml.item {
            xml.Title "活动介绍"
            xml.Description "活动说明文字，活动说明文字活动说明文字"
            xml.PicUrl URI.join(host, '/images/introduction.jpg')
            xml.Url URI.join(host, url_for(:activity, :intro, :openid => hash[:from_user_name]))
          }
          xml.item {
            xml.Title "进入抽奖活动"
            xml.Description "抽奖活动说明文字"
            xml.PicUrl URI.join(host, '/images/innovation_intro_header.jpg')
            xml.Url URI.join(host, url_for(:activity, :index, :openid => hash[:from_user_name]))
          }
        }
      }
    end
    builder.to_xml
  end
end
