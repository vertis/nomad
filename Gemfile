  source 'http://rubygems.org'

  gem 'rails', '>= 3.0.1'

  # The ORM which we will stake our application
  gem "mongoid"
  gem "bson_ext", ">= 1.1.1"


  # Background processing
  gem 'delayed_job'
  gem 'delayed_job_mongoid'

  # Authentication
  gem "devise"


  # Templating
  gem "haml", ">= 3.0.0"
  gem "haml-rails"

  # Easy jQuery helpers for rails3
  gem 'jquery-rails'

  gem 'nifty-generators'

  group :test do
    gem 'machinist_mongo', :require => 'machinist/mongoid', :git => 'http://github.com/nmerouze/machinist_mongo.git', :branch => 'machinist2'

    gem 'rspec-rails', '>= 2.0.1'
    gem 'mongoid-rspec'
    gem 'rcov'

    gem 'capybara'
    gem 'cucumber-rails'
    gem 'cucumber'

    gem 'spork'
    gem 'launchy'    # So you can do Then show me the page
  end
