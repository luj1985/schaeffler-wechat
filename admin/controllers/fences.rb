SchaefflerWechat::Admin.controllers :fences do
  get :index do
    if params[:option] == 'valid' then
      @fences = Fence.joins(:user).all.paginate(:page => params[:page])
    else
      @fences = Fence.includes(:user).all.paginate(:page => params[:page])
    end
    render "fences"
  end
end