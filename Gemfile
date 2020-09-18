source 'https://rubygems.org'
gemspec name: 'flipper'

Dir['flipper-*.gemspec'].each do |gemspec|
  plugin = gemspec.scan(/flipper-(.*)\.gemspec/).flatten.first
  gemspec(name: "flipper-#{plugin}", development_group: plugin)
end

gem 'pry'
gem 'rake', '~> 10.4.2'
gem 'shotgun', '~> 0.9'
gem 'statsd-ruby', '~> 1.2.1'
gem 'rspec', '~> 3.0'
gem 'rack-test', '~> 0.6.3'
gem 'sqlite3', '~> 1.3.11'
gem 'rails', "~> #{ENV['RAILS_VERSION'] || '4.2.11.1'}"
gem 'minitest', '~> 5.8.0'
gem 'webmock', '~> 2.0'

# for active support tests in test/ and only needed for ruby 2.2.x
gem 'test-unit', '~> 3.0'
