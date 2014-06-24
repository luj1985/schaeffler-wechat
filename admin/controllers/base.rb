SchaefflerWechat::Admin.controllers :base do
  get :index, :map => "/" do
    home = current_account.role.to_sym == :apps ? 
      url(:mobiles, :index) : url(:lotteries, :index)
    redirect home
  end
end
