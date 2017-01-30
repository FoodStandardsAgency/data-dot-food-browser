source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.1'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'haml-rails'
gem 'fsa_pattern_library', git: 'git@codebasehq.com:epimorphics/fsa-projects/fsa-pattern-library.git'
#gem 'fsa_pattern_library', path: '/home/ian/workspace/fsa/fsa-pattern-library'

#gem 'cairn_catalogue_browser', path: '/home/ian/workspace/epimorphics/cairn-catalogue-browser'
gem 'cairn_catalogue_browser', git: 'git@codebasehq.com:epimorphics/data-platform/cairn-catalogue-browser-72fdaa.git'

gem 'faraday'
gem 'faraday_middleware'
gem 'yajl-ruby', require: 'yajl'
