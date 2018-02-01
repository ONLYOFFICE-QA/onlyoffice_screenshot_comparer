source 'https://rubygems.org'

group :test do
  gem 'codecov', require: false
  gem 'rspec'
end

group :development do
  gem 'overcommit', require: false
  gem 'rubocop', require: false
end

gem 'mini_magick'
