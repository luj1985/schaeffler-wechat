module SchaefflerWechat
  class App < Padrino::Application
    register WillPaginate::Sinatra
    register LessInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    use Rack::Env
    register Padrino::Helpers
    
    enable :sessions

    error ActiveRecord::RecordNotFound do
      halt 404
      render 'errors/404'
    end

    error 403 do
      # return 200 to make jquerymobile show error page content
      # instead of "loading error"
      status 200
      render 'errors/403'
    end

    error 404 do
      render 'errors/404'
    end

    error 500 do
      render 'errors/500'
    end

    error 409 do
      render 'errors/409'
    end

    not_found do
      status 404
      render 'errors/404'
    end
    
    get :home, :map => '/' do
      render :home
    end
  end
end
