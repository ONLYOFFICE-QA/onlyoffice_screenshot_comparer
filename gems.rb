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
gem 'onlyoffice_s3_wrapper', git: 'https://github.com/onlyoffice-testing-robot/onlyoffice_s3_wrapper'
gem 'rake'
