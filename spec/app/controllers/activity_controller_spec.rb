require 'spec_helper'

describe "ActivityController" do
  before do
    get "/activity"
  end

  it "returns hello world" do
    last_response.body.should == "Hello World"
  end
end
