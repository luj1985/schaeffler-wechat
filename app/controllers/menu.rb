SchaefflerWechat::App.controllers :menu do
  
  get :index, :with => :name do
    # TODO: add menu image parse?
    @menus = Menu.where :name => params[:name]
    render :index
  end

end
