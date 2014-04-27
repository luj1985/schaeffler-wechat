SchaefflerWechat::Admin.controllers :lotteries do
  get :index do
    @title = "Lotteries"
    @lotteries = Lottery.all
    render 'lotteries/index'
  end

  get :export do
  end
end
