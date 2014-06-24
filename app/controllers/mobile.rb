SchaefflerWechat::App.controllers :mobile do
  
  get :index do
    render :index, :layout => :download
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
    halt 404
  end

end
