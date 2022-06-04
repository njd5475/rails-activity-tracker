source 'https://rubygems.org'

# add additional items here at the top.

gem 'exception_notification'

gem 'devise'
gem 'omniauth-google-oauth2'
# security patch https://nvd.nist.gov/vuln/detail/CVE-2015-9284
gem 'omniauth-rails_csrf_protection'
gem 'yarn'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap', '3.3.7'
  gem 'rails-assets-react-bootstrap'
  gem 'rails-assets-countdownjs'
  gem 'rails-assets-moment'
  gem 'rails-assets-moment-timezone'
  gem 'rails-assets-chartjs', '2.8.0'
  gem 'rails-assets-typeahead.js'
  gem 'rails-assets-reactjs--react-transition-group'
end

gem 'bower-rails', '~> 0.9.2'
# they told me too stackoverflow.com/questions/18878488/rails-4-coffeescript-only-works-when-there-is-a-post-request-or-when-i-reload-t
gem 'jquery-turbolinks'
gem 'backbone-rails'
gem 'haml-rails'
gem 'react-rails'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0'
# Use postgres as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 5.0.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'net-smtp'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use passenger for development
gem 'passenger', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.7.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  #gem 'spring'

  gem 'minitest'

  gem 'sqlite3'

  gem 'pry'

  gem 'pry-nav'

  gem 'listen'
end

group :development do

  gem 'guard'
  gem 'guard-livereload', '~> 2.4', require: false
  gem 'rack-livereload'
end
