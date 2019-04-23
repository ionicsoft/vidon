require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end

  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should get new" do
    get new_customer_url
    assert_response :success
  end 

  test "should create customer" do
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { person_attributes: { username: 
        "newuser", password: "123456", password_confirmation: "123456", email:
        "newuser@example.com", first_name: "New", last_name: "User" } } }
    end

    assert_redirected_to customer_url(Customer.last)
  end

  test "should show customer" do
    # get customer_url(@customer)
    # assert_response :success
  end

  test "should get edit" do
    log_in_as(@customer.person)
    get edit_customer_url(@customer)
    assert_response :success
  end

  # test "should update customer" do
  #   patch customer_url(@customer), params: { customer: { person_attributes: {
  #     username: "newuser", password: "123456", password_confirmation: "123456",
  #     email: "newuser@example.com", first_name: "New", last_name: "User" } } }
  #   assert_redirected_to customer_url(@customer)
  # end

  test "should destroy customer" do
    log_in_as(@customer.person)
    assert_difference('Customer.count', -1) do
      delete customer_url(@customer)
    end

    assert_redirected_to customers_url
  end
end
