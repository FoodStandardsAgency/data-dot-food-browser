source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
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
if RUBY_PLATFORM=~ /win32/
  gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
end

gem 'haml'
# gem 'fsa_pattern_library', git: 'git@codebasehq.com:epimorphics/fsa-projects/fsa-pattern-library.git'
gem 'faraday', '~> 0.15.0'
gem 'faraday_middleware', '~> 0.12.2'
gem 'kaminari', '~> 1.2.1'
gem 'listen', '~> 3.0.5'
gem 'yajl-ruby', require: 'yajl'

gem 'aws-sdk-rails'

gem 'webpacker', '~> 4.0'
