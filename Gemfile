#source 'https://rubygems.org'
source "http://ruby.taobao.org"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '6.1.7.3'

platforms :jruby do
  # Use jdbcmysql as the database for Active Record
  gem 'activerecord-jdbcmysql-adapter'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyrhino'
  # Use warbler to build the war package
  gem 'warbler', require: false, group: :development
end

# platforms :ruby do
  # Uncomment the next line if you want to use postgresql as the
  # database for Active Record
  #gem 'pg'

  # Uncomment the next line if you want to use MySQL as the database for
  # Active Record
  gem 'mysql2','<= 0.3.11'

  # Uncomment the next line if you want to use SQLite3 as the database
  # for Active Record
  #gem 'sqlite3'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', platforms: :ruby

  # gem "puma", '2.5.1'
# end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.2'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2.2'

# Use jquery as the JavaScript library
gem 'jquery-rails', '>= 4.4.0'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '>= 5.0.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.5', '>= 1.5.3'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '>= 1.0.0', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
group :development do
  gem 'capistrano', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-maintenance', require: false
  gem "better_errors", ">= 2.8.0"
  gem "pry"
end

group :test do
  gem 'debugger'
  gem 'rspec-rails'
  gem 'mocha'
  gem 'launchy'
  gem 'cucumber-rails', '>= 2.1.0', require: false
  gem 'database_cleaner'
  gem 'pickle', require: false
  gem 'selenium-webdriver'
  # gem 'capybara-webkit' if RUBY_PLATFORM =~ /darwin/
  gem 'ci_reporter','>= 1.9.0'
  gem 'simplecov'
  gem 'simplecov-rcov'
  gem "guard-rspec"
  gem "guard-cucumber"
  gem "spork"#-rails", github: "sporkrb/spork-rails"
  gem "guard-spork"
  gem "capybara"
  gem "site_prism", "~> 2.7"
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'faker'
end

gem 'omniauth', '>= 2.0.0'
gem 'omniauth-cas', '>= 1.1.1'

# Use prue css
gem 'purecss'

# add jquery datatable plug-in
gem 'jquery-datatables-rails'#, git: 'git://github.com/rweng/jquery-datatables-rails.git'

# add jquery fileupload plug-in
gem "jquery-fileupload-rails"

# Use qTip2 jQuery plugin show tooltip
gem 'jquery-qtip2-rails'

# Use jQuery gritter notification plug-in
gem "gritter", "~> 1.0.3"

# Use jquery ui sortable
gem 'jquery-ui-rails', '>= 6.0.0'

gem 'will_paginate', '~> 3.0'