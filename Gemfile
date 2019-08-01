source 'https://rubygems.org'

gem 'rails', '5.2.3'
gem 'sass-rails', '~> 5.0.6'
gem 'uglifier', '>= 1.3.0'
gem 'bootsnap'

gem 'smart_listing'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'bootstrap-datepicker-rails'
gem 'rest-client'
gem 'dotenv-rails'

gem 'kaminari'
gem 'log_file', github: 'prodigasistemas/log_file'
gem 'exception_notification'
gem 'slack-notifier'

gem "cliente-api", git: "https://gitlab.com/prodigasistemas/cliente-api.git"

gem "mechanize"

group :development, :test do
  gem 'pry-rails'
  gem 'awesome_print', require: 'ap'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'capistrano', '3.5.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'byebug'
  gem 'thin'
end

group :test do
  gem 'rspec-mocks'
  gem 'shoulda-matchers', '4.0.1'
end

group :production do
  gem 'unicorn'
end
