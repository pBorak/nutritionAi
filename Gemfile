source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "bcrypt", "~> 3.0"
gem "bootsnap", ">= 1.4.2", require: false
gem "jbuilder", "~> 2.9.1"
gem "knock"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.1"
gem "redis", "~> 3.0"
gem "responders"
gem "sidekiq"

group :development, :test do
  gem "pry-rails"
  gem "rspec-rails", "~> 4.0.0.beta3"
  gem "rubocop", "~> 0.77.0"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "spring"
end

group :test do
  gem "factory_bot_rails"
  gem "json_spec"
  gem "shoulda-matchers", require: false
  gem "simplecov", require: false
end
