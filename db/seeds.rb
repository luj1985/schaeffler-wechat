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




introduction_page =<<EOF
<h1>第三级页面</h1>
<img src="/images/activity/rules.jpg" />
<h4>申请观赛介绍：</h4>
<p>
舍弗勒集团将携手奥迪车队和保时捷车队分别参加2014年
<strong>DTM德国房车大师赛</strong>及<strong>WEC世界耐力锦标赛</strong>。
两项赛事的分站赛将先后于<strong>9月28日</strong>和
<strong>11月2日</strong>登陆广州及上海。
届时，我们将从正确回答申请观赛环节问题的中奖者中抽取
<strong class="highlight">超级幸运大奖</strong>，提供免费到现场激情观赛的机会！
</p>
<ul class="description">
<li>申请观赛截止日期为<strong>2014年10月1日</strong>，获奖者名单将在<strong>8月初</strong>以及<strong>10月</strong>初分两次公布。</li>
<li>每个微信ID只有一次申请观赛的机会，好好把握哦！</li>
</ul>
EOF


a1 = Article.create(:name => 'intro', :title => "赛事介绍", :abstract => "赛事介绍摘要", :body => introduction_page)
a2 = Article.create(:name => 'progress', :title => '敬请期待', :body => '<img src="/images/progress.jpg" />')
a3 = Article.create(:name => 'luk', :title => 'LuK离合器安装教程', :abstract => 'LuK离合器安装教程摘要', :body => '<p>LuK离合器安装教程</p>')
a4 = Article.create(:name => 'ina', :title => 'INA皮带传动部件及气门机构部件', :abstract => 'INA皮带传动部件及气门机构部件摘要', :body => '<p>INA皮带传动部件及气门机构部件</p>')
a5 = Article.create(:name => 'fag', :title => 'FAG轮毂轴承', :abstract => 'FAG轮毂轴承摘要', :body => '<p>FAG轮毂轴承</p>')
a6 = Article.create(:name => 'tools', :title => "工具列表", :body => '<h3>工具列表</h3><p>工具列表</p>')





m1 = Menu.create(:name => "matches", :title => "促销活动")
#sp1 = Page.create(:title => "“买舍弗勒产品，刮好礼，享速度与激情”", :abstract => '活动详情', :href => '/activity/intro', :image_href => '/images/introduction.jpg')
#sp2 = Page.create(:title => "促销活动兑奖页面", :abstract => '活动详情', :href => '/activity/index', :image_href => '/images/introduction.jpg')
#m1.pages << sp1
m1.articles << a1
m1.save


m2 = Menu.create(:name => "tutorial", :title => "安装教程")
m2.articles << a3 << a4 << a5
m2.save


m3 = Menu.create(:name => "diagnostic", :title => "故障诊断")
m3.articles << a3 << a4 << a5
m3.save



Question.create(:question => '舍弗勒在2014 DTM德国房车大师赛中赞助的车队是哪一支?', 
	:a=>'宝马车队', :b => '奥迪车队', :c => '奔驰车队', :d => '法拉利车队', :correct => 'b')
Question.create(:question => '舍弗勒在2014 WEC世界耐力锦标赛赞助的是哪一支车队?', 
	:a => '奥迪车队', :b => '丰田车队', :c => '红牛车队', :d => '保时捷车队', :correct => 'd')
Question.create(:question => '角逐DTM德国房车大师赛冠军的三家厂商车队以下哪三家？', 
	:a => '雷诺、宝马、丰田', :b => '奔驰、宝马、奥迪', :c => '法拉利、宝马、迈凯轮', :d => '奥迪、奔驰、本田', :correct => 'b')
Question.create(:question => 'DTM德国房车大师赛今年将首次登陆广州举行分站赛，你知道本站赛事的具体时间是几号吗？', 
	:a => '6月8号', :b => '9月28号', :c => '10月3号', :d => '12月20号', :correct => 'b')
Question.create(:question => '迄今为止,舍弗勒支持的车手共赢得几次德国房车大师赛冠军?', 
	:a => '1次', :b => '10次', :c => '4次', :d => '0次', :correct => 'c')


require 'csv'
path = File.join(File.dirname(__FILE__), 'test.csv')
CSV.foreach(path) do |row|
  crypted, level = row
  Lottery.create(:level => level, :crypted_serial => crypted)
end
