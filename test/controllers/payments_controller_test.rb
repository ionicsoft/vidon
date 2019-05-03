require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
  end
  
  test "should create payment with customer" do
    assert_difference('Customer.count', 1) do
      assert_difference('Payment.count', 1) do
        post customers_url, params: { customer: { person_attributes: { username: 
          "newuser", password: "123456", password_confirmation: "123456", email:
          "newuser@example.com", first_name: "New", last_name: "User" },
          payment_attributes: { card_name: "guy", card_num: "1234123412341234",
          cvc: 321, expiration: Date.today + 5.days}} }
      end
    end
  end
  
  test "should get edit" do
    log_in_as @payment.customer.person
    get edit_payment_url(@payment)
    assert_response :success
  end
  
  test "should get login for guest if edit" do
    get edit_payment_url(@payment)
    assert_redirected_to login_path
  end
  
  test "should not get other person's edit" do
    log_in_as payments(:two).customer.person
    get edit_payment_url(@payment)
    assert_redirected_to root_url
  end
  
  test "should update payment" do
    log_in_as @payment.customer.person
    get edit_payment_url(@payment)
    patch payment_url(@payment), params: {payment: {card_name: "Foo", card_num: "1111222233334444", cvc: "123", expiration: Time.now+5.days}}
    assert_redirected_to root_url
    assert_equal "Payment information successfully updated.", flash[:notice]
  end
  
  test "should not update payment with invalid data" do
    log_in_as @payment.customer.person
    get edit_payment_url(@payment)
    patch payment_url(@payment), params: {payment: {card_name: "", card_num: "", cvc: "", expiration: Time.now+5.days}}
    assert_template 'payments/edit'
  end
  
  test "should not update other customer's payment" do
    log_in_as @payment.customer.person
    patch payment_url(payments(:two)), params: {payment: {card_name: "Foo", card_num: "1111222233334444", cvc: "123", expiration: Time.now+5.days}}
    assert_redirected_to root_url
  end
end
