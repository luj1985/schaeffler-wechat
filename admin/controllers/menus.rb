SchaefflerWechat::Admin.controllers :menus do
  get :index do
    @title = "Menus"
    @menus = Menu.group('name').all
    render 'menus/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'menu')
    @menu = Menu.new
    render 'menus/new'
  end

  post :create do
    @menu = Menu.new(params[:menu])
    if @menu.save
      @title = pat(:create_title, :model => "menu #{@menu.id}")
      flash[:success] = pat(:create_success, :model => 'Menu')
      params[:save_and_continue] ? redirect(url(:menus, :index)) : redirect(url(:menus, :edit, :id => @menu.id))
    else
      @title = pat(:create_title, :model => 'menu')
      flash.now[:error] = pat(:create_error, :model => 'menu')
      render 'menus/new'
    end
  end

  put :add_article, :with => :id do
    menu = Menu.find(params[:id])
    article = Article.find(params[:article_id])
    menu.articles << article
    menu.save
    redirect(url(:menus, :edit, :id => params[:id]))
  end

  delete :remove_article, :with => [:id, :article_id] do
    menu = Menu.find(params[:id])
    article = Article.find(params[:article_id])
    menu.articles.delete(article)
    menu.save
    redirect(url(:menus, :edit, :id => params[:id]))
  end

  get :edit, :with => :id do
    @menu = Menu.find(params[:id])
    if @menu
      render 'menus/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'menu', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "menu #{params[:id]}")
    @menu = Menu.find(params[:id])
    if @menu
      if @menu.update_attributes(params[:menu])
        flash[:success] = pat(:update_success, :model => 'Menu', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:menus, :index)) :
          redirect(url(:menus, :edit, :id => @menu.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'menu')
        render 'menus/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'menu', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Menus"
    menu = Menu.find(params[:id])
    if menu
      if menu.destroy
        flash[:success] = pat(:delete_success, :model => 'Menu', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'menu')
      end
      redirect url(:menus, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'menu', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Menus"
    unless params[:menu_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'menu')
      redirect(url(:menus, :index))
    end
    ids = params[:menu_ids].split(',').map(&:strip)
    menus = Menu.find(ids)
    
    if Menu.destroy menus
    
      flash[:success] = pat(:destroy_many_success, :model => 'Menus', :ids => "#{ids.to_sentence}")
    end
    redirect url(:menus, :index)
  end
end
