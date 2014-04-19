require 'spec_helper'

describe "WechatController" do
	ECHOSTR = 'wechat echostr'
	
  before do
    get "/wechat", 
    	params = {:signature => '4a18c8f02ff399dcaa5ebd8f1fe190cd0c36a25f', :timestamp => '20140419', :nonce => 'nonce', :echostr => ECHOSTR},
    	rack_env = {:token => 'wechat-test-token'}
  end

  it "returns hello world" do
    last_response.body.should == ECHOSTR
  end
end
