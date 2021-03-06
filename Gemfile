# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '< 6'
# Use Puma as the app server
gem 'puma', '~> 5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
# gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara_minitest_spec'
  gem 'minitest-rails-capybara'
  gem 'minitest-reporters'
  gem 'mocha'
  gem 'simplecov'
  gem 'vcr'
end

group :development do
  gem 'rails_real_favicon'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby] if RUBY_PLATFORM =~ /win32/

gem 'haml'
# gem 'fsa_pattern_library', git: 'git@codebasehq.com:epimorphics/fsa-projects/fsa-pattern-library.git'
gem 'faraday', '~> 1.3'
gem 'faraday_middleware', '~> 1'
gem 'kaminari'
gem 'listen', '~> 3.0.5'
gem 'yajl-ruby', require: 'yajl'

gem 'aws-sdk-rails'
gem 'sentry-raven'

gem 'webpacker', '~> 5.0'
