
SchaefflerWechat::Admin.controllers :lotteries do
  get :index do
    @title = "Lotteries"
    if params[:show] == 'all' then
      @lotteries = Lottery.all
    else
      @lotteries = Lottery.where("serial is not null")
    end
    render 'lotteries/index'
  end

  get :export, :provides => [:csv, :xlsx] do
    @lotteries = Lottery.includes(:user).where("serial is not null")
    csv_string = CSV.generate(:force_quotes => true) do |csv|  
      csv << ["验证码","奖品","产品号","充值号码","OpenID","用户名","联系电话","省份","城市","详细地址","修理厂名"]  
      @lotteries.each do |l|
        user = l.user
        csv << [
          l.serial,
          l.display_name,
          l.product,
          l.tel,
          user.openid, 
          user.name,
          user.tel,
          user.province,
          user.city,
          user.workshop_address,
          user.workshop
        ]  
      end  
    end 
    csv_string
  end
end
