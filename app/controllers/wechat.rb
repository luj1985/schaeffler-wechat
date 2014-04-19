require '_wechat'

SchaefflerWechat::App.controllers :wechat do
  register Wechat::Events

  #TODO: should split wechat communication code
  wechat_event :click, :event_key => 'activity' do
  end

  wechat_event :click, :event_key => 'challenge' do
  end
end
