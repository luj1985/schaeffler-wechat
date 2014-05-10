module SchaefflerWechat
  class App < Padrino::Application
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
      render 'errors/403'
    end

    error 404 do
      render 'errors/404'
    end

    error 505 do
      render 'errors/505'
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
