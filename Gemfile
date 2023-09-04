# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.7"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

gem "ar_ulid"
gem "ulid"

group :development, :test do
  # Ruby code style checkers.
  gem "rubocop", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-gitlab-security", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rake", require: false
  gem "rubocop-rspec", require: false

  gem "factory_bot_rails"
  gem "ffaker"
  gem "rspec-rails"
end

gem "jwt", "~> 2.7"

gem "bcrypt", "~> 3.1"

gem "dry-transaction", "~> 0.15.0"

gem "dry-container", "~> 0.11.0"

gem "dry-validation", "~> 1.10"

gem "jsonapi.rb", "~> 2.0"

gem "ransack", "~> 4.0"

gem "action_policy", "~> 0.6.5"
