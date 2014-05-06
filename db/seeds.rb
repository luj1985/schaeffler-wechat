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

Menu.create(:name => "matches", :text => "test menu 1", :link => 'article1', :description => 'This is a test description for menu 1')
Menu.create(:name => "matches", :text => "test menu 2", :link => 'article2', :description => 'This is a test description for menu 2')
Menu.create(:name => "matches", :text => "test menu 3", :link => 'article3', :description => 'This is a test description for menu 3')
Menu.create(:name => "matches", :text => "test menu 4", :link => 'article4', :description => 'This is a test description for menu 4')
Menu.create(:name => "matches", :text => "test menu 5", :link => 'article5', :description => 'This is a test description for menu 5')
Menu.create(:name => "matches", :text => "test menu 6", :link => 'article6', :description => 'This is a test description for menu 6')
Menu.create(:name => "matches", :text => "test menu 7", :link => 'article7', :description => 'This is a test description for menu 7')

Article.create(:name => 'article1', :title => 'Article 1', :body => '<h3>Title of Article 1</h3><p>body of article 1</p>')
Article.create(:name => 'article2', :title => 'Article 2', :body => '<h3>Title of Article 2</h3><p>body of article 2</p>')
Article.create(:name => 'article3', :title => 'Article 3', :body => '<h3>Title of Article 3</h3><p>body of article 3</p>')
Article.create(:name => 'article4', :title => 'Article 4', :body => '<h3>Title of Article 4</h3><p>body of article 4</p>')
Article.create(:name => 'article5', :title => 'Article 5', :body => '<h3>Title of Article 5</h3><p>body of article 5</p>')
Article.create(:name => 'article6', :title => 'Article 6', :body => '<h3>Title of Article 6</h3><p>body of article 6</p>')
Article.create(:name => 'article7', :title => 'Article 8', :body => '<h3>Title of Article 7</h3><p>body of article 7</p>')


Question.create(:question => '阿拉伯神灯中主人公是', 
	:a=>'阿拉甲', :b => '阿拉乙', :c => '阿拉丙', :d => '阿拉丁', :correct => 'd')
Question.create(:question => '英文老歌 " Let it be " 的原唱是', 
	:a => '披头一', :b => '披头二', :c => '披头三', :d => '披头四', :correct => 'd')
Question.create(:question => '“给力”这个词出自以下哪本名著？', 
	:a => '《不给力啊，老湿》', :b => '《这货不是宿敌》', :c => '《西游记：旅程的终点》', :correct => 'a')
Question.create(:question => '中国最神秘的部门是神马部门？', 
	:a => '有关部门', :b => '无关部门', :c => '艳照门', :correct => 'a')
Question.create(:question => '贾君鹏的结局是', 
	:a => '被妈妈叫回家吃饭', :b => '过马路被泥头车撞飞了', :c =>  '在网吧继续打游戏', :d => '失踪了', :correct => 'a')


require 'csv'
path = File.join(File.dirname(__FILE__), 'test.csv')
CSV.foreach(path) do |row|
  crypted, level = row
  Lottery.create(:level => level, :crypted_serial => crypted)
end
