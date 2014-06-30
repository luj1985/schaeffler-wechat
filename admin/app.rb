module SchaefflerWechat
  class Admin < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    use Rack::Env
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    set :admin_model, 'Account'
    set :login_page,  '/sessions/new'

    enable  :sessions
    disable :store_location

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
    end

    access_control.roles_for :admin do |role|
      role.project_module :lotteries, '/lotteries', { :name => '已兑奖号码', :group => :promotion }
      role.project_module :users, '/users', { :name => '参与微信用户', :group =>  :promotion }
      role.project_module :questions, '/questions', { :name => '申请观赛问题', :group => :promotion }
      role.project_module :fences, '/fences', {:name => '用户活跃度', :group => :promotion }

      role.project_module :menus, '/menus', { :name => '微网页二级菜单', :group => :news }
      role.project_module :articles, '/articles', {:name => '微网页消息', :group => :news }
      role.project_module :pages, '/pages', { :name => '促销活动页面', :group => :news }

      role.project_module :auto_reply, '/wechat/auto_reply', { :name => '自动回复', :group => :wechat}
      role.project_module :wechat, '/wechat/menu', { :name => '微信菜单', :group => :wechat}
    end

    access_control.roles_for :admin, :apps do |role|
      role.project_module :accounts, '/accounts', {:name => '帐号管理', :group => :account }
    end
    
    access_control.roles_for :apps do |role|
      role.project_module :mobiles, '/mobiles', {:name => '手机APP推广', :group => :app }      
    end

    # Custom error management 
    error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
    error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
    error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }

    not_found do
      status 404
      @title = "Error 403"
      render('errors/404', :layout => :error)
    end
  end
end
