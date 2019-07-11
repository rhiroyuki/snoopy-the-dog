# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 2.6.3"

gem "rails", "~> 6.0.0.rc1"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "standard"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
