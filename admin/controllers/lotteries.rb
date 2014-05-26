
SchaefflerWechat::Admin.controllers :lotteries do
  get :index do
    @title = "促销活动兑奖"
    if params[:show] == 'all' then
      @lotteries = Lottery.includes(:user).all
    else
      @lotteries = Lottery.includes(:user).where("serial is not null")
    end
    render 'lotteries/index'
  end

  get :export, :provides => :xlsx do
    timestamp = Time.now.strftime "%Y-%m-%d %H%M%S"
    attachment "赛事促销活动#{timestamp}.xlsx"
    Axlsx::Package.new do |p|
      p.workbook.add_worksheet(:name => "兑奖帐号") do |sheet|
        sheet.add_row [
          "微信ID", "兑奖日期", "中奖号码","奖品等级", 
          "省","市","地址","修理厂名称", 
          "联系人姓名", "联系电话",
          "充值手机号", "产品号"
        ]

        @lotteries = Lottery.includes(:user).where("serial is not null")

        @lotteries.each do |l|
          u = l.user
          timestamp = l.exchange_time ? (l.exchange_time.strftime "%Y-%m-%d %H:%M:%S") : ""
          row = [
            u.openid, timestamp, l.serial, l.level_name,
            u.province, u.city, u.workshop_address, u.workshop, 
            u.name, u.tel,
            l.tel, l.product
          ]
          types = row.map {|v| :string }
          sheet.add_row row, :types => types
        end
      end

      p.workbook.add_worksheet(:name => '申请观赛') do |sheet|
        sheet.add_row [
          "微信ID", "申请观赛", 
          "申请时间", "省", "市", "地址", 
          "修理厂名称", "联系人", "联系方式", 
          "是否回答正确"
        ]
        User.all.each do |u|
          timestamp = u.apply_time ? (u.apply_time.strftime "%Y-%m-%d %H:%M:%S") : ""
          row = [
            u.openid, u.apply_attemped ? "是" : "否",
            timestamp, u.province, u.city, u.workshop_address,
            u.workshop, u.name, u.tel,
            u.join_match ? "是" : u.apply_attemped ? "否" : ""
          ]
          types = row.map {|v| :string }
          sheet.add_row row, :types => types
        end
      end
      s = p.to_stream
      response.write(s.read)
    end
  end
end
