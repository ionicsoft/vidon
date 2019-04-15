ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
  # Returns true if a test person is logged in.
  def is_logged_in?
    !session[:person_id].nil?
  end

  # Log in as a particular person.
  def log_in_as(person)
    session[:person_id] = person.id
  end
end
