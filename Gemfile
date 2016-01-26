source 'https://rubygems.org'

gem 'rails', '4.2.5'
gem 'pg'                         # Use postgresql as the database for Active Record
gem 'sass-rails', '~> 5.0'       # Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6' # Bootstrap!
gem 'uglifier', '>= 1.3.0'       # Use Uglifier as compressor for JavaScript assets
gem 'jquery-rails'               # Use jquery as the JavaScript library
gem 'jbuilder', '~> 2.0'         # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'slim-rails'
gem 'autoprefixer-rails', '~> 6.3.1'
gem 'omniauth'
gem 'omniauth-github'
gem 'acts_as_votable', '~> 0.10.0'
gem 'rest-client'
gem 'github_api', '~> 0.13.1'
gem 'puma'
gem 'redcarpet'
gem 'react_webpack_rails', '0.0.5'
gem 'turbolinks', git: 'git://github.com/rails/turbolinks.git', ref: 'dd31f4b2996f2300631f89339ada82c65b95f4c2'
gem 'nprogress-rails'

group :development do
  gem 'spring'            # Spring speeds up development by keeping your application running in the background
  gem 'bullet'            # Helps to kill N+1 queries and unused eager loading
  gem 'better_errors'     # Gives MUCH better errors in development
  gem 'binding_of_caller' # Necessary for better_error's REPL
  gem 'colorize'          # Provides easier-to-parse rake output
end

group :development, :test do
  gem 'pry-rails'               # Use pry for the rails console
  gem 'spring-commands-rspec'   # Implements the rspec command for Spring
  gem 'rspec-rails', '~> 3.4.0' # Use rspec for testing
  gem 'factory_girl_rails'      # A fixtures replacement with a straightforward definition syntax
  gem 'guard-rspec'             # Watches our app for changes, to automatically and selectively run tests
end

group :test do
  gem 'capybara', '~> 2.6.0'         # Helpers to simulate how a real user would interact with your app
  gem 'database_cleaner', '~> 1.5.1' # A set of strategies for cleaning your database
  gem 'launchy', '~> 2.4.3'          # Facilitates launching external applications
  gem 'poltergeist'                  # PhantomJS driver for Capybara
  gem 'webmock', '~> 1.22.3'         # For stubbing and setting expectations on HTTP requests
  gem 'codeclimate-test-reporter', require: false
end

group :production do
  gem 'rollbar', '~> 2.7.1'
  gem 'oj', '~> 2.14.2'
  gem 'newrelic_rpm'
end
