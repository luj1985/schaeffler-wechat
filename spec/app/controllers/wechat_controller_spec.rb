require 'spec_helper'

describe "WechatController" do
  context "access support" do

    let (:echostr) {
      'wechat echostr'
    }
    let(:params) { {
      :signature => '4a18c8f02ff399dcaa5ebd8f1fe190cd0c36a25f', 
      :timestamp => '20140419', 
      :nonce => 'nonce', 
      :echostr => echostr
      }
    }
    
    before do
      get "/wechat", params, rack_env = {:token => 'wechat-test-token'}
    end

    it "return echo string" do
      last_response.should be_ok
      last_response.body.should == echostr
    end
  end

  context "menu push event support" do
    let (:body) {
      <<-EOF
<xml>
  <ToUserName>target wechat id</ToUserName>
  <FromUserName>client open id</FromUserName>
  <CreateTime>123456789</CreateTime>
  <MsgType>event</MsgType>
  <Event>click</Event>
  <EventKey>source key</EventKey>
</xml>
EOF
    }

    before do
      post "/wechat", body
    end

    it "return activity url" do
      last_response.should be_ok
      last_response.should have_content_type('application/xml').with_charset('utf-8')
    end
  end
end
