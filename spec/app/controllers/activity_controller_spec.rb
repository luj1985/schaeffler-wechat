require 'spec_helper'

describe "ActivityController" do
  before do
    get "/activity/thisisopenid"
  end

  it "access home page" do
    last_response.should be_ok
  end
end
