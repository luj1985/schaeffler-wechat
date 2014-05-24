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


a1 = Article.create(:name => 'intro', :title => "赛事介绍", :body => introduction_page)
a2 = Article.create(:name => 'progress', :title => '敬请期待', :body => '<img src="/images/progress.jpg" />')
a3 = Article.create(:name => 'luk', :title => 'LuK离合器安装教程', :body => '<p>LuK离合器安装教程</p>')
a4 = Article.create(:name => 'ina', :title => 'INA皮带传动部件及气门机构部件', :body => '<p>INA皮带传动部件及气门机构部件</p>')
a5 = Article.create(:name => 'fag', :title => 'FAG轮毂轴承', :body => '<p>FAG轮毂轴承</p>')
a6 = Article.create(:name => 'tools', :title => "工具列表", :body => '<h3>工具列表</h3><p>工具列表</p>')





m1 = Menu.create(:name => "matches", :title => "“买舍弗勒产品，刮好礼，享速度与激情”")
m1.articles << a1
m1.save


m2 = Menu.create(:name => "tutorial", :title => "安装教程")
m2.articles << a3 << a4 << a5
m2.save


m3 = Menu.create(:name => "diagnostic", :title => "故障诊断")
m3.articles << a3 << a4 << a5
m3.save





Question.create(:question => '阿拉伯神灯中主人公是', 
	:a=>'阿拉甲', :b => '阿拉乙', :c => '阿拉丙', :d => '阿拉丁', :correct => 'd')
Question.create(:question => '英文老歌 " Let it be " 的原唱是', 
	:a => '披头一', :b => '披头二', :c => '披头三', :d => '披头四', :correct => 'd')
Question.create(:question => '中国最神秘的部门是神马部门？', 
	:a => '有关部门', :b => '无关部门', :c => '艳照门', :correct => 'a')


require 'csv'
path = File.join(File.dirname(__FILE__), 'test.csv')
CSV.foreach(path) do |row|
  crypted, level = row
  Lottery.create(:level => level, :crypted_serial => crypted)
end
