# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development'  unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require 'csv'
Bundler.require(:default, RACK_ENV)

require 'time'

##
# ## Enable devel logging
#
Padrino::Logger::Config[:development][:log_level]  = :devel
Padrino::Logger::Config[:development][:log_static] = true
#
# ## Configure your I18n
#
I18n.default_locale = :zh_cn
# I18n.enforce_available_locales = false
#
# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end
Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:role, :mini)
##
# Add your before (RE)load hooks here
#
Padrino.before_load do
  envfile = File.join(Dir.getwd, '.env')
  File.readlines(envfile).each do |line|
    key, value = line.split "="
    ENV[key] = value.chomp!
  end if File.exists? envfile
  
  require 'will_paginate'
  require 'will_paginate/active_record'
  require 'will_paginate/view_helpers/sinatra'
  require 'bootstrap_pagination/sinatra'
  include WillPaginate::Sinatra::Helpers
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
end

Padrino.load!
