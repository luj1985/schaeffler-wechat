
SchaefflerWechat::Admin.helpers do
  def lottery_name lottery
  	t("activity.result.#{lottery.name}")
  end

  def lottery_status lottery
  	t("activity.result.status.#{lottery.status}")
  end
end
