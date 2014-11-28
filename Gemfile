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

#Pretty stuff
gem 'font-awesome-rails'
gem 'bootstrap-sass'
gem 'formtastic', '~> 2.0'
gem 'formtastic-bootstrap', '~> 3.0'

#Site Wide Announcements
gem 'starburst', github: 'jhenkens/starburst', branch: 'master'


# Let's get all of our pretty JS libraries from Bower! This gets updated way faster
source 'http://rails-assets.org' do # This is bad, but https isn't verifying
  #To validate forms nicely
  gem 'rails-assets-bootstrapvalidator'
  #For the portfolio feature
  gem 'rails-assets-isotope'
  #Popover images
  gem 'rails-assets-lightbox2'
  #Not really sure, but it sounds cool!
  gem 'rails-assets-retina.js'
  #CSS For fancy social buttons
  gem 'rails-assets-bootstrap-social'
  #Delay execution till images are loaded
  gem 'rails-assets-imagesloaded'
  #Kinda like retina
  gem 'rails-assets-modernizr'
  #Admin hotkey enabler
  gem 'rails-assets-jeresig--jquery.hotkeys'

  #Some problem with Gemfile.lock isn't pulling this in on prod, so lets manually get it
  gem 'rails-assets-desandro--get-size'
end


#included anyways by bootstrap-sass, but lets require it for our project as well.
gem 'autoprefixer-rails'

## MOVED THESE GEMS OUT BECAUSE WE NEED THEM TO SEED DATA
gem 'factory_girl_rails', '~> 4.4'
gem 'faker', '~> 1.3'
## END MOVED GEMS

#Gives us some great tools for finding slowness
gem 'newrelic_rpm'
#Suggest users to upgrade their browser if they are using old versions
gem 'browser'


group :development, :test do
  gem 'sqlite3'
  gem 'dotenv-rails', '~> 0.11'
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
  gem 'therubyracer', platforms: :ruby
  gem 'mysql2'

  #Tame down the rails logs a bit
  gem 'lograge'
  gem 'rails_12factor'

end
