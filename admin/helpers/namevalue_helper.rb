SchaefflerWechat::Admin.helpers do

  def event_pair value
    hash = {
      'subscribe' => '订阅事件',
      'click' =>  '菜单事件',
      'keyword' => '关键字回复'
    }
    hash[value]
  end

  def rtype_pair value
    hash = {
      'text' => '文本消息',
      'news' => '图文消息'
    }
    hash[value]
  end
end
