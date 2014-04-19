# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end


guard :rspec, cmd: 'bundle exec rspec --color -f doc' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/controllers/(.+)\.rb}) { |m| "spec/app/controllers/#{m[1]}_controller_spec.rb" }
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/app/#{m[1]}_spec.rb" }
  watch(%r{^models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }
  watch('spec/spec_helper.rb') { "spec" }
end
