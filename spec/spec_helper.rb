RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f }
# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app SchaefflerWechat::App
#   app SchaefflerWechat::App.tap { |a| }
#   app(SchaefflerWechat::App) do
#     set :foo, :bar
#   end
#

def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end


# app SchaefflerWechat::App do
# 	set :protect_from_csrf, false
# end