source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '~>4.0.0'
gem 'railties', '~>4.0.0'
# gem 'rails', '3.2.11'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'bootstrap_form'
gem 'bcrypt-ruby', '3.0.0'
gem 'fabrication'
gem 'faker'
gem 'factory_girl_rails'
platforms :ruby do
  gem 'unicorn'
end
gem 'carrierwave'
gem 'mini_magick', :git => 'git://github.com/minimagick/minimagick.git', :ref => '6d0f8f953112cce6324a524d76c7e126ee14f392'
gem 'sidekiq'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  # gem 'sass-rails',   '~> 3.2.3'
  # gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'sqlite3'
  gem 'letter_opener'
  # gem 'better_errors'
  # gem 'binding_of_caller'
end

group :production do
  gem 'newrelic_rpm'
  gem 'pg'
  gem 'rails_12factor'
  gem 'sinatra', require: false
  gem 'slim'
  gem 'fog'
end

gem 'jquery-rails'

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-nav'
  gem 'rack-mini-profiler'
  gem 'foreman'
end