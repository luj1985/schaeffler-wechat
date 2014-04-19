require '_wechat'

SchaefflerWechat::App.controllers :wechat do
  register Wechat::Events

  wechat_event :click, :event_key => 'activity' do |hash|
    host = ENV['WECHAT_HOST']
    activity_path = url_for(:activity, :index)
    image_path = '/images/activity/activity.jpg'
    builder = Nokogiri::XML::Builder.new do |xml|
      xml.xml {
        xml.ToUserName hash[:from_user_name]
        xml.FromUserName hash[:to_user_name]
        xml.CreateTime Time.now.to_i
        xml.MsgType "news"
        xml.ArticleCount 1
        xml.Articles {
          xml.item {
            xml.Title "Welcome to join Schaeffler activity"
            xml.Description "This is Schaeffler test activity"
            xml.PicUrl URI.join(host, image_path)
            xml.Url URI.join(host, activity_path)
          }
        }
      }
    end
    builder.to_xml
  end
end
