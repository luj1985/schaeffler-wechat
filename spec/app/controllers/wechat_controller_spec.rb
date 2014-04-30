require 'spec_helper'

describe "WechatController" do
  context "access support" do

    let (:echostr) {
      'wechat echostr'
    }
    
    let(:params) { {
      :signature => '80862eb64cfeb6f419f98dd6a089ce54962502cb', 
      :timestamp => '20140419', 
      :nonce => 'nonce', 
      :echostr => echostr
      }
    }
    
    before do
      get "/wechat", params, rack_env = {"WECHAT_TOKEN" => 'test'}
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
  <ToUserName>targetwechatid</ToUserName>
  <FromUserName>clientopenid</FromUserName>
  <CreateTime>123456789</CreateTime>
  <MsgType>event</MsgType>
  <Event>click</Event>
  <EventKey>activity</EventKey>
</xml>
EOF
    }

    before do
      post "/wechat?signature=80862eb64cfeb6f419f98dd6a089ce54962502cb&timestamp=20140419&nonce=nonce", body
    end

    it "return activity url" do
      last_response.should be_ok
      last_response.should have_content_type('application/xml').with_charset('utf-8')
      last_response.body.should include("<ToUserName>clientopenid</ToUserName>")
      last_response.body.should include("<FromUserName>targetwechatid</FromUserName>")
      last_response.body.should include("<MsgType>news</MsgType>")
      last_response.body.should include("<ArticleCount>1</ArticleCount>")
    end

  end
end
