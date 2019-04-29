ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!
require 'capybara/rails'
require 'capybara/minitest'
require 'capybara/rspec'


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
  
  def log_in_as_customer
    visit login_path
    fill_in('Username', with: 'bob')
    fill_in('Password', with: 'password')
    click_button 'Login'
  end
  
  def log_in_as_producer
    visit login_path
    fill_in('Username', with: 'laura')
    fill_in('Password', with: 'password')
    click_button 'Login'
  end
end

class ActionDispatch::IntegrationTest

  # Log in as a particular person.
  def log_in_as(person, password: 'password', remember_me: '1')
    post login_path, params: { session: { username: person.username,
                                          password: password,
                                          remember_me: remember_me } }
  end
  
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  # Reset sessions and driver between tests
  # Use super wherever this method is redefined in your individual test classes
  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
  
end
