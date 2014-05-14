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

  get :export, :provides => :xlsx do
    timestamp = Time.now.strftime "%Y-%m-%d %H%M%S"
    attachment "参与用户#{timestamp}.xlsx"
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "参与用户 #{timestamp}") do |sheet|
        sheet.add_row [
          "OpenID","用户名","联系电话",
          "提交观赛申请", 
          "申请结果",
          "省份","城市","详细地址","修理厂名"]
        User.all.each do |u|
          row = [u.openid, u.name, u.tel, 
            u.apply_attemped ? "是" : "否",
            u.join_match ? "成功" : u.apply_attemped ? "失败" : "", 
            u.province, u.city, u.workshop_address, u.workshop ]
          types = row.map {|v| :string }
          sheet.add_row row, :types => types
        end
      end
      s = p.to_stream
      response.write(s.read)
    end
  end
end
