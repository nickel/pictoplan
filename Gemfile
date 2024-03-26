# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.3"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "bootsnap", require: false
gem "devise"
gem "image_processing"
gem "importmap-rails"
gem "jbuilder"
gem "packwerk"
gem "pg"
gem "puma"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"

group :development, :test do
  gem "debug", platforms: %i(mri windows)
end

group :development do
  gem "brakeman"
  gem "bundler-audit"
  gem "foreman"
  gem "rubocop"
  gem "spring"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
