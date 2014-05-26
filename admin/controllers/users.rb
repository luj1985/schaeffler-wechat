SchaefflerWechat::Admin.controllers :users do
  get :index do
    @title = "微信用户列表"
    @users = User.all
    render 'users/index'
  end

  get :edit, :with => :id do
    @title = "编辑微信用户信息"
    @user = User.find(params[:id])
    if @user
      render 'users/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'User', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = "编辑微信用户信息"
    @user = User.find(params[:id])
    if @user
      if @user.update_attributes(params[:user])
        flash[:success] = "用户#{@user.name}数据已更新"
        redirect(url(:users, :edit, :id => @user.id))          
      else
        flash.now[:error] = pat(:update_error, :model => 'user')
        render 'users/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'user', :id => "#{params[:id]}")
      halt 404
    end
  end
end
