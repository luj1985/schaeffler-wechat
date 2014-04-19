require 'crack'
require '_wechat'

SchaefflerWechat::App.controllers :wechat do
  register Wechat::Events

  #TODO: should split wechat communication code
  wechat :menu, :with => 'activity' do

  end

  wechat :text do
  end
end
