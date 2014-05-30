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




# introduction_page =<<EOF
# <img src="/images/activity/rules.jpg" />
# <h4>申请观赛介绍：</h4>
# <p>
# 舍弗勒集团将携手奥迪车队和保时捷车队分别参加2014年
# <strong>DTM德国房车大师赛</strong>及<strong>WEC世界耐力锦标赛</strong>。
# 两项赛事的分站赛将先后于<strong>9月28日</strong>和
# <strong>11月2日</strong>登陆广州及上海。
# 届时，我们将从正确回答申请观赛环节问题的中奖者中抽取
# <strong class="highlight">超级幸运大奖</strong>，提供免费到现场激情观赛的机会！
# </p>
# <ul class="description">
# <li>申请观赛截止日期为<strong>2014年10月1日</strong>，获奖者名单将在<strong>8月初</strong>以及<strong>10月</strong>初分两次公布。</li>
# <li>每个微信ID只有一次申请观赛的机会，好好把握哦！</li>
# </ul>
# EOF


# a1 = Article.create(:name => 'intro', :title => "“买舍弗勒产品，刮好礼，享速度与激情”", :abstract => "活动详情", :body => introduction_page)

matches_page =<<EOF
<img src="/images/matches/1.jpg" />
<p>2014年，舍弗勒再次与奥迪凤凰车队合作，征战德国房车大师赛（DTM）。作为主赞助商，参赛车辆涂装依旧是与众不同的黄绿色。</p>
<img src="/images/matches/2.jpg" />
<p>2013赛季证明了舍弗勒选择赞助伙伴上有一双“幸运的手”，我们的车手Mike和冠军车队凤凰车队的成绩，印证了舍弗勒与DTM拍档之间成功的合作关系。</p>
<p>2013赛季中，Mike Rockenfeller所用的是舍弗勒与奥迪合作的RS5 DTM车型。在倒数第二站赞德沃特赛道，他就已经能够将冠军头衔收入囊中。在赛季的最后，经过车队和车手的密切配合，舍弗勒奥迪凤凰车队成功拿下DTM车队冠军头衔。</p>
<img src="/images/matches/3.jpg" />
<p>2014赛季，舍弗勒在选择合作伙伴时毫不犹豫，继续与奥迪凤凰车队及车手Mike Rockenfeller携手，朝着成功卫冕的目标努力。</p>
<img src="/images/matches/4.jpg" />
<p>从2000年的重新启动至今，德国房车大师赛（DTM）走过了第十五个赛季，今年奥迪，宝马和梅赛德斯奔驰将再次角逐这世上最受欢迎的汽车赛事，所有的车队都将拿出最新款的赛车出战。</p>
<p>2014年DTM赛季于4月30日德国正式开始， 5月4日第一轮于4.574公里的德国霍根海姆赛道上进行了42圈的激烈争夺。</p>
<img src="/images/matches/5.jpg" />
<p>2014年DTM增加了中国赛区广州分站的比赛（9月27/28日）。</p>
<p>近在咫尺的世界赛事，怎能错过？舍弗勒中国汽车售后将诚邀忠实客户，一同亲临广州站现场，为奥迪凤凰车队及车手加油助威！</p>
<p>如何才能成为万众瞩目的幸运儿？答案就在舍弗勒汽车售后近期的微信内容。</p>
<p>敬请期待。</p>
<img src="/images/matches/6.jpg" />
EOF
a2 = Article.create(:name => 'matches', 
	:title => '舍弗勒与奥迪携手征战DTM', 
	:body => matches_page)
# a3 = Article.create(:name => 'luk', :title => 'LuK离合器安装教程', :abstract => 'LuK离合器安装教程摘要', :body => '<p>LuK离合器安装教程</p>')
# a4 = Article.create(:name => 'ina', :title => 'INA皮带传动部件及气门机构部件', :abstract => 'INA皮带传动部件及气门机构部件摘要', :body => '<p>INA皮带传动部件及气门机构部件</p>')
# a5 = Article.create(:name => 'fag', :title => 'FAG轮毂轴承', :abstract => 'FAG轮毂轴承摘要', :body => '<p>FAG轮毂轴承</p>')



a6 = Article.create(:name => 'tools', :title => "【FAG专题】舍弗勒汽车售后首部微电影隆重登场", :abstract => '工具及附件',
	:body => '<img src="/images/articles/tools.png" />')




a7 = Article.create(:name => 'tutorial', :title => '【LuK专题】自调试离合器 (SAC)，来自LuK的原创', :abstract => '安装教程',
	:body => '<img src="/images/articles/tutorial.png" />')

a8 = Article.create(:name => 'tutorial1', :title => '还在用榔头砸轮毂轴承？那就out了！', :abstract => '安装教程',
	:body => '<img src="/images/articles/tutorial.png" />')



a9 = Article.create(:name => 'diagnostic', :title => '【FAG专题】轮毂轴承常见故障诊断', :abstract => '摘要',
	:body => '<img src="/images/articles/diagnostic.png" />')
a10 = Article.create(:name => 'diagnostic1', :title => '【LuK专题】常见离合器故障诊断', :abstract => '摘要',
	:body => '<img src="/images/articles/diagnostic.png" />')
a11 = Article.create(:name => 'diagnostic2', :title => '【LuK专题】双质量飞轮故障诊断', :abstract => '摘要',
	:body => '<img src="/images/articles/diagnostic.png" />')



m1 = Menu.create(:name => "matches", :title => "促销活动")


sp1 = Page.create(:title => "促销活动一级页面", :abstract => '活动详情', :href => '/activity/intro', :image_href => '/images/cover.jpg')
sp2 = Page.create(:title => "“买舍弗勒产品，刮好礼，享速度与激情”", :abstract => '活动详情', :href => '/activity/intro1', :image_href => '/images/cover.jpg')
sp3 = Page.create(:title => "促销活动兑奖页面", :abstract => '活动详情', :href => '/activity/index', :image_href => '/images/introduction.jpg')
sp4 = Page.create(:title => "敬请期待", :abstract => "摘要", :href => '/activity/progress', :image_href => '/images/progress.jpg')

m1.pages << sp2
m1.save



m2 = Menu.create(:name => "tutorial", :title => "安装教程", :image => "/images/menu/tutorial.jpg")
m2.articles << a7 << a8
m2.save


m3 = Menu.create(:name => "diagnostic", :title => "故障诊断", :image => '/images/menu/diagnostic.jpg')
m3.articles << a9 << a10 << a11
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
