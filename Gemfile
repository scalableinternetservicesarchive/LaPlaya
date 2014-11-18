source 'https://rubygems.org'

#ruby '2.1.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.1.6'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Added Gems
#Authentication
gem 'devise'
gem 'omniauth-facebook'
# gem 'omniauth-github'
gem 'omniauth-google-oauth2'
# gem 'omniauth-clever', github: 'code-dot-org/omniauth-clever', branch: 'master'
gem 'cancancan'
gem 'will_paginate'

#Javascript isolation
gem 'paloma'

#Allow us to do global hotkeys in our site (admin user switcher for example)
gem 'jquery-hotkeys-rails'

gem 'modernizr-rails'

#Pretty stuff
gem 'font-awesome-rails'
gem 'bootstrap-sass'
gem 'formtastic', '~> 2.0'
gem 'formtastic-bootstrap', '~> 3.0'
gem 'bootstrap-validator-rails'

#included anyways by bootstrap-sass, but lets require it for our project as well.
gem 'autoprefixer-rails'


group :development, :test do
  gem 'sqlite3'
  gem 'dotenv-rails', '~> 0.11'
  gem 'factory_girl_rails', '~> 4.4'
  gem 'faker', '~> 1.3'
  gem 'rspec-rails', '~> 3.1'
  gem 'fuubar', '~> 2.0'
  gem 'rspec-expectations', '~> 3.1'
  gem 'rspec-its', '~> 1.1'
  gem 'rspec-collection_matchers', '~> 1.1'
  gem 'rspec-mocks', '~> 3.1'
  gem 'childprocess', '~> 0.5'
end

group :development do
  #Rubymine debugging
  gem 'ruby-debug-ide'
  gem 'debase'

  #nice debugging in your browser
  gem 'better_errors'
  #allows interpreted ruby while debugging in browser
  gem 'binding_of_caller'
  #enables RailsPanel chrome developer addon
  gem 'meta_request'
  gem 'rack-mini-profiler'
end

# Use mysql2 as the production database for Active Record
group :production do
  gem 'therubyracer',  platforms: :ruby
  gem 'mysql2'
end
