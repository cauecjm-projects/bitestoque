source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',            '~> 5.2.0'
gem 'pg',               '~> 0.18'
gem 'puma',             '~> 3.11'
gem 'sass-rails',       '~> 5.0'
gem 'uglifier',         '>= 1.3.0'
gem 'coffee-rails',     '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks',       '~> 5'
gem 'jbuilder',         '~> 2.5'
gem 'bootstrap',        '~> 4.3.1'
gem 'mini_racer'
gem 'responders'
gem 'jquery_mask_rails'

gem 'factory_bot_rails'
gem 'ffaker'
gem 'database_cleaner'
gem 'shoulda-matchers'
gem 'rails-controller-testing'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'web-console',           '>= 3.3.0'
  gem 'listen',                '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
