# frozen_string_literal: true

source 'https://rubygems.org'

group :test do
  gem 'rspec'
  gem 'simplecov-cobertura', require: false
end

group :development do
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

gem 'mini_magick'
gem 'onlyoffice_s3_wrapper'
gem 'rake'
