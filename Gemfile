source 'https://rubygems.org'

ruby '2.6.4'
gem 'rails', '5.2.7'
gem 'bootsnap', '~> 1.4.6', require: false

# Assets
gem 'sass-rails', '~> 5.0.7'
gem 'coffee-rails' , '~> 4.2.2'
gem 'uglifier' , '>= 4.1.0'

# Temporarily adding compass-rails for backward compatibility during upgrade
gem 'compass-rails', '~> 3.1.0'
gem 'pg', '~> 1.0.0' # Postgresql adapter - compatible with Rails 5.2
gem 'virtus' # Model generation in simple way
#gem 'squeel' # Better SQL queries

gem 'simple_form', '~> 5.0.0'  # Compatible with Rails 5.2
# Template engines
# gem 'haml', '~> 5.1.2'  # Compatible with Rails 5.0
gem 'erubis', '~> 2.7.0'
# gem 'erb', '~> 2.2.0'
gem 'kaminari', '~> 1.2.1' # Pagination
gem 'bcrypt', '~> 3.1.16', require: 'bcrypt'
gem 'active_model_serializers', '~> 0.10.12' # ActiveRecord Classes to encode in JSON
gem 'resubject' # Cool presenter

gem 'validates_email_format_of'#, '~> 1.5.3'
gem 'validates_lengths_from_database'
# Hstore accessor
gem 'hstore_accessor'
gem 'jsonb_accessor', '~> 1.1.0'  # Compatible with Rails 5.2
gem 'dragonfly', '~> 1.4.0'

gem "rack-cors", '~> 1.1.1', require: "rack/cors"

gem "responders", "~> 3.0.0"  # Compatible with Rails 5.2

group :production do
  gem 'newrelic_rpm', '~> 6.15.0'  # Compatible with Rails 5.2
  gem 'bugsnag', '~> 6.24.0' # Report of errors
  gem 'rack-cache', '~> 1.13.0', require: 'rack/cache'
end

group :development do
  gem "better_errors", '~> 2.9.1'
  gem "binding_of_caller", '~> 1.0.0'
  gem "meta_request", '~> 0.7.3'
  gem "rails_best_practices", '~> 1.23.0'
  # quiet_assets functionality is built into Rails 5+
  gem "bullet", '~> 6.1.5'
  gem "awesome_print", '~> 1.9.2'

  gem "capistrano", '~> 3.16.0'
  gem "capistrano-rails", '~> 1.6.1'
  gem "capistrano-bundler", '~> 2.0.1'
  gem "capistrano-rvm", '~> 0.1.2'
  gem 'web-console', '~> 3.7.0'
  gem 'spring', '~> 2.1.1'
  gem 'spring-commands-rspec', '~> 1.0.4'
  gem 'listen', '~> 3.1.5' # Required for Rails 5.2 file watcher
end

group :development, :test do
  gem "puma", '~> 4.3.12' # Web server - compatible with Ruby 2.6
  gem "rspec-rails", '~> 4.0.2'  # Compatible with Rails 5.2
  gem "ffaker", '~> 2.20.0'
  gem "pry-byebug", '~> 3.9.0'
end

# Test
group :test do
  gem "capybara", '~> 3.35.3'  # Compatible with Rails 5.2
  gem "database_cleaner", '~> 1.8.5'  # Compatible with Rails 5.2
  gem "factory_bot_rails", '~> 6.2.0' # Compatible with Rails 5.2
  gem "shoulda-matchers", '~> 5.0.0', require: false  # Compatible with Rails 5.2
  gem "valid_attribute", '~> 2.0.0'
  gem "watchr", '~> 0.7'
  gem "launchy", '~> 2.5.0'
  gem 'rails-controller-testing', '~> 1.0.5'  # For assigns and assert_template in Rails 5.2
end
