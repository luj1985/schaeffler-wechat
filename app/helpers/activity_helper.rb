SchaefflerWechat::App.helpers do
  def lottery_name lottery
    t("activity.result.#{lottery.name}")
  end

  def lottery_message lottery
  	name = lottery_name lottery
    lottery.level == '4' ? 
    	t("activity.result.greet4") : 
    	t("activity.result.greet", :name => name)
  end
end
