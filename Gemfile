source 'https://rubygems.org'

# Distribute your app as a gem
# gemspec

# Server requirements
# gem 'thin' # or mongrel
# gem 'trinidad', :platform => 'jruby'

# Optional JSON codec (faster performance)
# gem 'oj'

# Project requirements
gem 'rake'

# Component requirements
gem 'will_paginate', '~>3.0'
gem 'will_paginate-bootstrap'
gem 'bcrypt'
gem 'therubyracer'
gem 'rack-less'
gem 'less'
gem 'haml'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'activerecord-import'
gem 'sqlite3'

# Test requirements
gem 'rspec', :group => 'test'
gem 'rack-test', :require => 'rack/test', :group => 'test'

gem 'sinatra-wechat'
gem 'wechat-adapter'
gem 'nokogiri'

# Padrino Stable Gem
gem 'padrino', '0.12.1'

group :development, :test do
  gem 'guard'
  gem 'guard-livereload'
  gem 'guard-rspec'
  gem 'pry'
  gem 'pry-nav'
end

gem 'unicorn'
gem 'axlsx'
# Or Padrino Edge
# gem 'padrino', :github => 'padrino/padrino-framework'

# Or Individual Gems
# %w(core support gen helpers cache mailer admin).each do |g|
#   gem 'padrino-' + g, '0.12.1'
# end
