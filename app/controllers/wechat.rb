require 'digest'

SchaefflerWechat::App.controllers :wechat do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  
  get :index do
    signature = params[:signature]
    timestamp = params[:timestamp]
    nonce = params[:nonce]
    echostr = params[:echostr]
    token = ENV["token"] || 'test'

    puts token

    raw = [token, timestamp, nonce].compact.sort.join
    hash = Digest::SHA1.hexdigest(raw)

    hash == signature ? echostr : ""
  end
end
