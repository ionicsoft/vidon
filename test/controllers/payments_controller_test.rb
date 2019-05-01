require 'test_helper'

class PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payment = payments(:one)
    @customer = customers(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@customer.person)
  end

  test "should get index" do
    get payments_url
    #assert_response :redirect
    assert_response :success
  end

  test "should get new" do
    get new_payment_url
    #assert_response :redirect
    assert_response :success
  end

  test "should create payment" do
    #does not create payment
    @temp = Customer.create
    assert_difference('Payment.count') do
      post payments_url, params: { payment: { card_name: "JoJo Cujoh", card_num: "1111222233334444", cvc: 123, expiration: Date.today + 5.days, customer_id: @temp.id } }
    end

    assert_redirected_to payment_url(Payment.last)
  end

  test "should show payment" do
    get payment_url(@payment)
    assert_response :success
  end

  test "should get edit" do
    get edit_payment_url(@payment)
    #assert_response :redirect
    assert_response :success
  end

  test "should update payment" do
    patch payment_url(@payment), params: { payment: { card_name: @payment.card_name, card_num: @payment.card_num, cvc: @payment.cvc, expiration: @payment.expiration, customer_id: @payment.customer_id } }
    #assert_redirected_to payment_url(@payment)
  end

  test "should destroy payment" do
    #does not destroy payment
    assert_difference('Payment.count', -1) do
      delete payment_url(@payment)
    end

    assert_redirected_to payments_url
  end
end
