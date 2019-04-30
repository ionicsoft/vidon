require 'test_helper'

class InvoicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@person)
  end
  
  test "should create invoice" do
    assert_difference('Invoice.count', 1) do
      post invoices_url, params: { invoice: { payment_id: 1, amount: 5, description: "test payment" } }
    end
  end
end
