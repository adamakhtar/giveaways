# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../spec/dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'byebug'

Dir[File.expand_path(File.join(File.dirname(__FILE__),"support","**","*.rb"))].each {|f| require f}

ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.use_instantiated_fixtures  = false
  config.infer_spec_type_from_file_location!
end
