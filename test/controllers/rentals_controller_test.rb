require 'test_helper'

class RentalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as_customer
  end
  
  test "should create rental" do
    assert_difference('Rental.count', 1) do
      post rentals, params: { movie_id: 1, customer_id: 1}
    end
  end
end
