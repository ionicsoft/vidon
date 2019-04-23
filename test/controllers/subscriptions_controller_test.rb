require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
    @customer = Customer.first.person
  end

  test "should get index" do
    log_in_as @customer
    get subscriptions_url
    assert_response :success
  end

  test "should get new" do
    log_in_as @customer
    get new_subscription_url
    assert_response :success
  end

  # test "should create subscription" do
  #   assert_difference('Subscription.count') do
  #     post subscriptions_url, params: { subscription: { current_episode: @subscription.current_episode, customer_id: @subscription.customer_id, show_id: @subscription.show_id } }
  #   end

  #   assert_redirected_to subscription_url(Subscription.last)
  # end

  test "should show subscription" do
    log_in_as @customer
    get subscription_url(@subscription)
    assert_response :success
  end

  test "should get edit" do
    log_in_as @customer
    get edit_subscription_url(@subscription)
    assert_response :success
  end

  # test "should update subscription" do
  #   patch subscription_url(@subscription), params: { subscription: { current_episode: @subscription.current_episode, customer_id: @subscription.customer_id, show_id: @subscription.show_id } }
  #   assert_redirected_to subscription_url(@subscription)
  # end

  test "should destroy subscription" do
    log_in_as @customer
    assert_difference('Subscription.count', -1) do
      delete subscription_url(@subscription)
    end

    assert_redirected_to subscriptions_url
  end
end
