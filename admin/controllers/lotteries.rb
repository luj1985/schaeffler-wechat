SchaefflerWechat::Admin.controllers :lotteries do
  get :index do
    @title = "Lotteries"
    @lotteries = Lottery.all
    render 'lotteries/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'lottery')
    @lottery = Lottery.new
    render 'lotteries/new'
  end

  post :create do
    @lottery = Lottery.new(params[:lottery])
    if @lottery.save
      @title = pat(:create_title, :model => "lottery #{@lottery.id}")
      flash[:success] = pat(:create_success, :model => 'Lottery')
      params[:save_and_continue] ? redirect(url(:lotteries, :index)) : redirect(url(:lotteries, :edit, :id => @lottery.id))
    else
      @title = pat(:create_title, :model => 'lottery')
      flash.now[:error] = pat(:create_error, :model => 'lottery')
      render 'lotteries/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "lottery #{params[:id]}")
    @lottery = Lottery.find(params[:id])
    if @lottery
      render 'lotteries/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'lottery', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "lottery #{params[:id]}")
    @lottery = Lottery.find(params[:id])
    if @lottery
      if @lottery.update_attributes(params[:lottery])
        flash[:success] = pat(:update_success, :model => 'Lottery', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:lotteries, :index)) :
          redirect(url(:lotteries, :edit, :id => @lottery.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'lottery')
        render 'lotteries/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'lottery', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Lotteries"
    lottery = Lottery.find(params[:id])
    if lottery
      if lottery.destroy
        flash[:success] = pat(:delete_success, :model => 'Lottery', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'lottery')
      end
      redirect url(:lotteries, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'lottery', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Lotteries"
    unless params[:lottery_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'lottery')
      redirect(url(:lotteries, :index))
    end
    ids = params[:lottery_ids].split(',').map(&:strip)
    lotteries = Lottery.find(ids)
    
    if Lottery.destroy lotteries
    
      flash[:success] = pat(:destroy_many_success, :model => 'Lotteries', :ids => "#{ids.to_sentence}")
    end
    redirect url(:lotteries, :index)
  end
end
