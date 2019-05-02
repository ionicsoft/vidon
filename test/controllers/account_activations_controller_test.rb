require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end
  test "should activate account" do
    test_email = "activationtest@example.com"
    customer = Customer.create!(person_attributes: {
      email: test_email, 
      password: "password",
      password_confirmation: "password",
      first_name: "Foo",
      last_name: "Bar",
      username: "activationtest"
    })
    
    get edit_account_activation_url(customer.person.activation_token, email: customer.person.email)
    assert_equal 'Account activated!', flash[:notice]
  end
end
