require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end
  test "should activate account" do
    @customer.person.update_attribute(:activated, false)
    get edit_account_activation_url(@customer.person)
    byebug
    assert_equal 'Account activated!', flash[:notice]
  end
end
