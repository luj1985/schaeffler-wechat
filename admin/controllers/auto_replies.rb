SchaefflerWechat::Admin.controllers :auto_replies do
  get :index do
    @title = "Auto_replies"
    @auto_replies = AutoReply.all
      .where(params.reject {|k, v| k == "page" })
      .order(:event => :desc, :weight => :desc)
      .paginate(:page => params[:page])
    render 'auto_replies/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'auto_reply')
    @auto_reply = AutoReply.new
    render 'auto_replies/new'
  end

  post :create do
    @auto_reply = AutoReply.new(params[:auto_reply])
    if @auto_reply.save
      @title = pat(:create_title, :model => "auto_reply #{@auto_reply.id}")
      flash[:success] = pat(:create_success, :model => 'AutoReply')
      params[:save_and_continue] ? redirect(url(:auto_replies, :index)) : redirect(url(:auto_replies, :edit, :id => @auto_reply.id))
    else
      @title = pat(:create_title, :model => 'auto_reply')
      flash.now[:error] = pat(:create_error, :model => 'auto_reply')
      render 'auto_replies/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "auto_reply #{params[:id]}")
    @auto_reply = AutoReply.find(params[:id])
    if @auto_reply
      render 'auto_replies/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'auto_reply', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "auto_reply #{params[:id]}")
    @auto_reply = AutoReply.find(params[:id])
    if @auto_reply
      if @auto_reply.update_attributes(params[:auto_reply])
        flash[:success] = pat(:update_success, :model => 'Auto_reply', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:auto_replies, :index)) :
          redirect(url(:auto_replies, :edit, :id => @auto_reply.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'auto_reply')
        render 'auto_replies/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'auto_reply', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Auto_replies"
    auto_reply = AutoReply.find(params[:id])
    if auto_reply
      if auto_reply.destroy
        flash[:success] = pat(:delete_success, :model => 'Auto_reply', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'auto_reply')
      end
      redirect url(:auto_replies, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'auto_reply', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Auto_replies"
    unless params[:auto_reply_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'auto_reply')
      redirect(url(:auto_replies, :index))
    end
    ids = params[:auto_reply_ids].split(',').map(&:strip)
    auto_replies = AutoReply.find(ids)
    
    if AutoReply.destroy auto_replies
    
      flash[:success] = pat(:destroy_many_success, :model => 'Auto_replies', :ids => "#{ids.to_sentence}")
    end
    redirect url(:auto_replies, :index)
  end
end
