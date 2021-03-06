
SchaefflerWechat::Admin.controllers :lotteries do
  get :index do
    @title = "促销活动兑奖"
    startTime = Time.parse(params[:start]) if params[:start] && !params[:start].empty?
    endTime = Time.parse(params[:end]) if params[:end] && !params[:end].empty?

    @lotteries = Lottery.includes(:user).where("serial is not null")
    @lotteries = @lotteries.where('exchange_time > ?', startTime) if startTime
    @lotteries = @lotteries.where('exchange_time < ?', endTime) if endTime

    @lotteries = @lotteries.order('exchange_time asc').paginate(:page => params[:page])
    render 'lotteries'
  end

  get :export, :provides => :xlsx do
    startTime = Time.parse(params[:start]) if params[:start] && !params[:start].empty?
    endTime = Time.parse(params[:end]) if params[:end] && !params[:end].empty?

    timestamp = ''
    if startTime || endTime then
      timestamp += ' ' + (startTime.strftime "%Y-%m-%d") if startTime
      timestamp += '~'
      timestamp += (endTime.strftime "%Y-%m-%d") if endTime
    else
      timestamp = '~' + (Time.now.strftime "%Y-%m-%d %H%M%S")
    end

    attachment "赛事促销活动 #{timestamp}.xlsx"
    Axlsx::Package.new do |p|
      wb = p.workbook
      wb.styles.fonts.first.name = '微软雅黑'
      wb.styles do |s|
        header_style = s.add_style  :b => true,
                                    :sz => 12,
                                    :alignment => { :horizontal=> :center },
                                    :border => { :style => :hair, :color => "00" }

        title_style = s.add_style :bg_color => 'FFFF00', 
                                  :b => false, 
                                  :sz => 12,
                                  :alignment => { :horizontal=> :center },
                                  :border => { :style => :hair, :color => "00" }
        body_style = s.add_style  :b => false,
                                  :sz => 12,
                                  :border => { :style => :hair, :color => "00" }
        wb.add_worksheet(:name => "兑奖帐号") do |sheet|
          sheet.add_row ["赛事促销活动 兑奖管控表"], :style => header_style
          sheet.merge_cells("A1:N1")
          sheet.add_row [
            "微信ID", "兑奖日期", "兑奖月份", "兑奖日期", "中奖号码","奖品等级", 
            "省","市","地址","修理厂名称", 
            "联系人姓名", "联系电话",
            "充值手机号", "产品号"
          ], :style => title_style

          @lotteries = Lottery.includes(:user).where("serial is not null")

          @lotteries = @lotteries.where('exchange_time > ?', startTime) if startTime
          @lotteries = @lotteries.where('exchange_time < ?', endTime) if endTime
          @lotteries = @lotteries.order('exchange_time asc')
          @lotteries.each do |l|
            u = l.user
            timestamp = l.exchange_time ? (l.exchange_time.localtime.strftime "%Y-%m-%d %H:%M:%S") : ""
            month = l.exchange_time ? l.exchange_time.localtime.month : ''
            day = l.exchange_time ? l.exchange_time.localtime.day : ''
            row = [
              u.openid, timestamp, month, day, l.serial, l.level_name,
              u.province, u.city, u.workshop_address, u.workshop, 
              u.name, u.tel,
              l.tel, l.product
            ]
            types = row.map {|v| :string }
            sheet.add_row row, :types => types, :style => body_style
          end
        end

        wb.add_worksheet(:name => '申请观赛') do |sheet|
          sheet.add_row ["赛事促销活动 申请观赛管控表"], :style => header_style
          sheet.merge_cells("A1:J1")
          sheet.add_row [
            "微信ID", "申请观赛", 
            "申请时间", "省", "市", "地址", 
            "修理厂名称", "联系人", "联系方式", 
            "是否回答正确"
          ], :style => title_style
          User.all.each do |u|
            timestamp = u.apply_time ? (u.apply_time.localtime.strftime "%Y-%m-%d %H:%M:%S") : ""
            row = [
              u.openid, u.apply_attemped ? "是" : "否",
              timestamp, u.province, u.city, u.workshop_address,
              u.workshop, u.name, u.tel,
              u.join_match ? "是" : u.apply_attemped ? "否" : ""
            ]
            types = row.map {|v| :string }
            sheet.add_row row, :types => types, :style => body_style
          end
        end
      end      
      s = p.to_stream
      response.write(s.read)
    end
  end

end
