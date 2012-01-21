  source 'http://rubygems.org'

  gem 'rails', '3.1.3'
  
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


  # Templating
  gem "haml", ">= 3.0.0"
  gem "haml-rails"

  gem 'nifty-generators'
  gem 'twitter-bootstrap-rails', "~> 1.4.3"
  
  gem 'simple_form', :git => 'git://github.com/plataformatec/simple_form.git'

  group :test do
    gem 'machinist_mongo', :require => 'machinist/mongoid', :git => 'http://github.com/nmerouze/machinist_mongo.git', :branch => 'machinist2'

    gem 'rspec-rails', '>= 2.0.1'
    #gem 'mongoid-rspec'
    gem 'rcov'

    gem 'database_cleaner'
    gem 'capybara', '>= 1.1.2'
    gem 'cucumber-rails', '~> 1.2.1'
    gem 'cucumber'

    gem 'spork'
    gem 'launchy'    # So you can do Then show me the page
  end
