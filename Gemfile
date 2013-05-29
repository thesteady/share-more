source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'jquery-rails'

# gem 'paperclip'
gem 'haml'
gem 'sorcery'
gem 'simple_form'
gem 'aced_rails'


group :production do 
  gem 'pg'
end

group :test do 
  gem 'webmock'
  gem 'simplecov', :require => false
end

group :development do 
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test, :development do 
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.0'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'vcr'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
