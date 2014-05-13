
SchaefflerWechat::Admin.controllers :lotteries do
  get :index do
    @title = "促销活动兑奖"
    if params[:show] == 'all' then
      @lotteries = Lottery.all
    else
      @lotteries = Lottery.where("serial is not null")
    end
    render 'lotteries/index'
  end

  get :export, :provides => [:csv, :xlsx] do
    @lotteries = Lottery.includes(:user).where("serial is not null")
    timestamp = Time.now.strftime "%Y-%m-%d %H%M%S"
    attachment "已兑奖号码#{timestamp}.xlsx"
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "已被兑奖号码 #{timestamp}") do |sheet|
        sheet.add_row ["验证码","奖品","产品号","充值号码","OpenID","用户名","联系电话","省份","城市","详细地址","修理厂名"]
        @lotteries.each do |l|
          u = l.user
          row = [ l.serial, l.display_name, l.product, l.tel, 
            u.name, u.tel, u.province, u.city, u.workshop_address, u.workshop
          ]
          types = row.map {|v| :string }
          sheet.add_row row, :types => types
        end
      end
      s = p.to_stream()
      response.write(s.read)
    end
  end
end
