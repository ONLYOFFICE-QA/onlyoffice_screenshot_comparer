# frozen_string_literal: true

if ENV['CI'] == 'true'
  require 'simplecov'
  SimpleCov.start
  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require_relative '../lib/onlyoffice_screenshot_comparer'
