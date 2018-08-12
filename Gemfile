source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# core
gem 'rails', '~> 5.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false

# serializers
gem 'active_model_serializers', '~> 0.10.0'

# configs
gem 'dotenv-rails'

group :development, :test do
  # debug
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-byebug'

  # specs
  gem 'rspec-rails', '~> 3.7'
  gem 'fuubar'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
