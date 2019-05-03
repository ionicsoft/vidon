require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    test_email = "activationtest@example.com"
    @customer = Customer.create!(person_attributes: {
      email: test_email, 
      password: "password",
      password_confirmation: "password",
      first_name: "Foo",
      last_name: "Bar",
      username: "activationtest"
    })
  end
  test "should activate account" do
    get edit_account_activation_url(@customer.person.activation_token, email: @customer.person.email)
    assert_equal 'Account activated!', flash[:notice]
  end
  
  test "should not activate with invalid auth" do
    get edit_account_activation_url("12345", email: @customer.person.email)
    assert_equal 'Invalid activation link', flash[:danger]
  end
  
  test "should not activate twice with valid link" do
    get edit_account_activation_url(@customer.person.activation_token, email: @customer.person.email)
    assert_equal 'Account activated!', flash[:notice]
    get edit_account_activation_url(@customer.person.activation_token, email: @customer.person.email)
    assert_equal 'Invalid activation link', flash[:danger]
  end
  
  test "should not activate without matching email" do
    get edit_account_activation_url(@customer.person.activation_token, email: "bad_example@example.com")
    assert_equal 'Invalid activation link', flash[:danger]
  end
end
