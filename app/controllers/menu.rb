SchaefflerWechat::App.controllers :menu do
  
  get :index, :with => :name do
    # TODO: add menu image parse?
    @menu = Menu.find_by_name params[:name]
    puts @menu
    render :index
  end

end
