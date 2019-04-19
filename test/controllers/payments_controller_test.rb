require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
    @customer = Customer.first.person
  end

  test "should get index" do
    log_in_as(@customer)
    get payments_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@customer)
    get new_payment_url
    assert_response :success
  end

  test "should create payment" do
    log_in_as(@customer)
    assert_difference('Payment.count') do
      post payments_url, params: { payment: { card_name: @payment.card_name, card_num: @payment.card_num, cvc: @payment.cvc, expiration: @payment.expiration, customer_id: @payment.customer_id } }
    end

    assert_redirected_to payment_url(Payment.last)
  end

  test "should show payment" do
    log_in_as(@customer)
    get payment_url(@payment)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@customer)
    get edit_payment_url(@payment)
    assert_response :success
  end

  test "should update payment" do
    log_in_as(@customer)
    patch payment_url(@payment), params: { payment: { card_name: @payment.card_name, card_num: @payment.card_num, cvc: @payment.cvc, expiration: @payment.expiration, customer_id: @payment.customer_id } }
    assert_redirected_to payment_url(@payment)
  end

  test "should destroy payment" do
    log_in_as(@customer)
    assert_difference('Payment.count', -1) do
      delete payment_url(@payment)
    end

    assert_redirected_to payments_url
  end
end
