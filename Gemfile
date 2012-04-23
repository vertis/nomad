source 'http://rubygems.org'

gem 'rails', '3.1.4'
  
# Gems used only for assets and not required  
# in production environments by default.  
group :assets do  
  gem 'sass-rails', " ~> 3.1.0"  
  gem 'coffee-rails', " ~> 3.1.0"  
  gem 'uglifier'  
end  
  
gem 'jquery-rails' 

# The ORM which we will stake our application
gem "mongoid", '>= 2.1.0'
gem "bson_ext", ">= 1.5.2"

# Authentication
gem "devise"

# Unicorns and stuff
gem "unicorn"
gem "foreman"

# Deployment
gem "capistrano"
gem "capistrano-ext"
gem "capistrano_colors"

# Monitoring  
gem 'newrelic_rpm'
gem 'exceptional'

# Templating
gem "haml", ">= 3.0.0"
gem "haml-rails"

gem 'twitter-bootstrap-rails', :git => 'https://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'font-awesome-rails'
 
gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'

# HTTP
gem 'httparty'

# Settings
gem 'settingslogic'

# Breadcrumbs
gem "crummy", "~> 1.5.0"

group :test do
  gem 'machinist_mongo', :require => 'machinist/mongoid', :git => 'http://github.com/nmerouze/machinist_mongo.git', :branch => 'machinist2'

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
