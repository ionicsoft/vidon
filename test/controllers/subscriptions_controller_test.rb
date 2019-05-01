require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
    @customer = Customer.first.person
    log_in_as(@customer)
  end

  test "should create subscription" do
    assert_difference('Subscription.count', 1) do
      post subscriptions_url, params: { subscription: { current_episode: 1, customer_id: @customer.user_id, show_id: @subscription.show_id } }, headers: { 'HTTP_REFERER' => @subscription.show }
    end

    assert_redirected_to @subscription.show
  end

  test "should update subscription" do
    patch subscription_url(@subscription), params: { subscription: { current_episode: @subscription.current_episode, customer_id: @subscription.customer_id, show_id: @subscription.show_id } }
    assert_redirected_to "/"
  end
end
