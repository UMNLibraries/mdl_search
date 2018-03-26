source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'mysql2', '~> 0.3.18'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.2'
# # Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# # Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer'
# # Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'coffee-rails', '~> 4.2'
# # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# # bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails'
  gem 'capistrano-sidekiq'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-passenger'
  gem 'fontello_rails_converter'
  gem 'coveralls', require: false
end

group :test, :development do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'solr_wrapper', '>= 0.3'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'teaspoon-jasmine'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'capybara-webkit'
  gem 'vcr'
  gem 'webmock'
end

gem 'blacklight', '~> 6.10.1'
gem 'rsolr', '~> 2.0.2'
gem 'globalid'
gem 'webpacker'

# # CONTENTdm ETL
gem 'devise'
gem 'devise-guests'
gem 'hash_at_path'
gem 'cdmbl'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'sidekiq-failures'
gem 'whenever', :require => false

# Autmatically link URLs in citation details
gem 'rinku'
