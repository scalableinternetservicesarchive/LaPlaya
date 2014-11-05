source 'https://rubygems.org'

#ruby '2.1.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', group: :development
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Added Gems
#Authentication
gem 'devise'
gem 'switch_user', github: 'jhenkens/switch_user', branch: 'master'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-google-oauth2'
gem 'omniauth-clever'

#Javascript isolation
gem 'paloma'

#Allow us to do global hotkeys in our site (admin user switcher for example)
gem 'jquery-hotkeys-rails'

gem 'masonry-rails'
gem 'modernizr-rails'

#Pretty stuff
gem 'font-awesome-rails'
gem 'prettyphoto-rails'
gem 'bootstrap-sass'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'bootstrap-validator-rails'

gem 'autoprefixer-rails'


group :development, :test do
  gem 'dotenv-rails', '~> 0.11.1'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'faker', '~> 1.3.0'
  gem 'rspec-rails', '~> 3.1'
  gem 'fuubar', '~> 2.0.0'
  gem 'rspec-expectations', '~> 3.1'
  gem 'rspec-its', '~> 1.0.1'
  gem 'rspec-collection_matchers', '~> 1.0.0'
  gem 'spork-rails', '~> 4.0.0'
  gem 'guard-rspec', '~> 4.2.8'
  gem 'guard-spork', '~> 1.5.1'
  gem 'childprocess', '~> 0.5.2'
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
gem 'mysql2', group: :production
