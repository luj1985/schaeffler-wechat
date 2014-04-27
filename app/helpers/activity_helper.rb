SchaefflerWechat::App.helpers do

  def lottery_name lottery
  	t("activity.result.#{lottery.name}")
  end
  
end
