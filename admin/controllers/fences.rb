SchaefflerWechat::Admin.controllers :fences do
  get :index do
  	@fences = Fence.includes(:user).all.paginate(:page => params[:page])
    render "fences/index"
  end
end