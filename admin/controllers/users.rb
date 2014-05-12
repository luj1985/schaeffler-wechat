SchaefflerWechat::Admin.controllers :users do
  get :index do
    @title = "Users"
    @users = User.all
    render 'users/index'
  end

  get :export, :provides => [:csv, :xlsx] do
    csv_string = CSV.generate(:force_quotes => true) do |csv|  
      csv << ["OpenID","用户名","联系电话","申请观赛","省份","城市","详细地址","修理厂名"]  
      User.all.each do |u|
        csv << [
          u.openid, 
          u.name,
          u.tel,
          u.join_match ? "申请观赛成功" : "",
          u.province,
          u.city,
          u.workshop_address,
          u.workshop
        ]
      end 
    end
    csv_string
  end
end
