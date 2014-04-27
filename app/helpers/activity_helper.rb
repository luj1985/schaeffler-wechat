# Helper methods defined here can be accessed in any controller or view in the application

SchaefflerWechat::App.helpers do
  def lottery_name lottery
  	t("activity.result.#{lottery.name}")
  end
end
