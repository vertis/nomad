source 'https://rubygems.org'

gem 'rails', '~> 3.2.16'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', " ~> 3.2.3"
  gem 'coffee-rails', " ~> 3.2.1"
  gem 'uglifier', '>=1.0.3'
  gem 'less-rails'
  gem 'therubyracer'
  gem 'libv8', '~> 3.11.8'
end

gem 'jquery-rails'

# The ORM which we will stake our application
gem "mongoid", '~> 2.1.0'
gem "bson_ext", "~> 1.5.2"

# Authentication
gem "devise", '~> 1.5'

# Unicorns and stuff
gem "unicorn"
gem "foreman"

# Deployment
gem "mina"
gem "nokogiri"

# Monitoring
gem 'newrelic_rpm'
gem 'exceptional'

# Templating
gem "haml", ">= 3.0.0"
gem "haml-rails"

gem 'twitter-bootstrap-rails', :git => 'https://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'font-awesome-rails'

gem 'simple_form'

# HTTP
gem 'httparty'

# Settings
gem 'settingslogic'

# Breadcrumbs
gem "crummy", "~> 1.5.0"

group :test do
  gem 'machinist_mongo', :require => 'machinist/mongoid', :git => 'https://github.com/nmerouze/machinist_mongo.git', :branch => 'machinist2'

  gem 'rspec-rails', '>= 2.0.1'
  #gem 'mongoid-rspec'
  gem 'simplecov', :require => false

  gem 'database_cleaner'
  gem 'capybara', '>= 1.1.2'
  gem "capybara-webkit"
  gem 'cucumber-rails', '~> 1.2.1'
  gem 'cucumber-rails-training-wheels'
  gem 'cucumber'

  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
end
