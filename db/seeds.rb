# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
# email     = shell.ask "Which email do you want use for logging into admin?"
# password  = shell.ask "Tell me the password to use:"

# shell.say ""

# account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

# if account.valid?
#   shell.say "================================================================="
#   shell.say "Account has been successfully created, now you can login with:"
#   shell.say "================================================================="
#   shell.say "   email: #{email}"
#   shell.say "   password: #{password}"
#   shell.say "================================================================="
# else
#   shell.say "Sorry but some thing went wrong!"
#   shell.say ""
#   account.errors.full_messages.each { |m| shell.say "   - #{m}" }
# end

# shell.say ""

account = Account.create(:email => "test@example.com", :name => "Jun", :surname => "Lu", :password => "test", :password_confirmation => "test", :role => "admin")
# md5sum
# e11170b8cbd2d74102651cb967fa28e5 => 1111111111
# 3a08fe7b8c4da6ed09f21c3ef97efce2 => 2222222222
# 4aee3e28df37ea1af64bd636eca59dcb => 3333333333
# e53a68903e2c336a890907125b489abd => 4444444444
# 781e5e245d69b566979b86e28d23f2c7 => 0123456789
# 312f04f99be9e857bfb2c033eeb1d3e2 => 8888888888
Lottery.create(:name => "Level 1", :crypted_serial => "e11170b8cbd2d74102651cb967fa28e5")
Lottery.create(:name => "Level 2", :crypted_serial => "3a08fe7b8c4da6ed09f21c3ef97efce2")
Lottery.create(:name => "Level 3", :crypted_serial => "4aee3e28df37ea1af64bd636eca59dcb")
Lottery.create(:name => "Level 4", :crypted_serial => "e53a68903e2c336a890907125b489abd")
Lottery.create(:name => "Level 1", :crypted_serial => "781e5e245d69b566979b86e28d23f2c7")
Lottery.create(:name => "Level 4", :crypted_serial => "312f04f99be9e857bfb2c033eeb1d3e2")


Menu.create(:name => "home", :text => "test menu 1", :link => 'article1', :description => 'This is a test description for menu 1')
Menu.create(:name => "home", :text => "test menu 2", :link => 'article2', :description => 'This is a test description for menu 2')
Menu.create(:name => "home", :text => "test menu 3", :link => 'article3', :description => 'This is a test description for menu 3')
Menu.create(:name => "home", :text => "test menu 4", :link => 'article4', :description => 'This is a test description for menu 4')
Menu.create(:name => "home", :text => "test menu 5", :link => 'article5', :description => 'This is a test description for menu 5')
Menu.create(:name => "home", :text => "test menu 6", :link => 'article6', :description => 'This is a test description for menu 6')
Menu.create(:name => "home", :text => "test menu 7", :link => 'article7', :description => 'This is a test description for menu 7')

Article.create(:name => 'article1', :title => 'Article 1', :body => '<h3>Title of Article 1</h3><p>body of article 1</p>')
Article.create(:name => 'article2', :title => 'Article 2', :body => '<h3>Title of Article 2</h3><p>body of article 2</p>')
Article.create(:name => 'article3', :title => 'Article 3', :body => '<h3>Title of Article 3</h3><p>body of article 3</p>')
Article.create(:name => 'article4', :title => 'Article 4', :body => '<h3>Title of Article 4</h3><p>body of article 4</p>')
Article.create(:name => 'article5', :title => 'Article 5', :body => '<h3>Title of Article 5</h3><p>body of article 5</p>')
Article.create(:name => 'article6', :title => 'Article 6', :body => '<h3>Title of Article 6</h3><p>body of article 6</p>')
Article.create(:name => 'article7', :title => 'Article 8', :body => '<h3>Title of Article 7</h3><p>body of article 7</p>')
