SchaefflerWechat::App.controllers :mobile do
  
  get :index do
    render :index, :layout => :download
  end

  get :download do
    render :download, :layout => false
  end

  get :android do
    mobile = Mobile.find_by_os :android
    halt 404 if mobile.nil?
    mobile.count += 1
    mobile.save

    path = "public/" + mobile.file
    send_file(path, :filename => "schaeffler-android.apk", 
      :type => 'application/vnd.android.package-archive')
  end

  get :ios do
    mobile = Mobile.find_by_os :ios
    halt 404 if mobile.nil?

    mobile.count += 1
    mobile.save
    redirect "https://itunes.apple.com/cn/app/she-fu-lei-chan-pin-zhu-shou/id899938848"
  end

end
