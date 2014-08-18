begin
  require 'database_cleaner'
  require 'database_cleaner/cucumber'

  DatabaseCleaner.strategy = :truncation, {:except => %w[statuses content_packs]}
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

Before do
  load "#{Rails.root}/db/seeds.rb"
  DatabaseCleaner.start
end

After do |scenario|
  DatabaseCleaner.clean
end
