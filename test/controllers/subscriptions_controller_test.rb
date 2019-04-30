require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
    @customer = Customer.first.person
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@customer)
  end

  test "should get index" do
    get subscriptions_url
    #assert_response :redirect
    assert_response :success
  end

  test "should get new" do
    get new_subscription_url
    #assert_response :redirect
    assert_response :success
  end

  test "should create subscription" do
    #does not create subscription
    assert_difference('Subscription.count', 1) do
      post subscriptions_url, params: { subscription: { current_episode: 1, customer_id: @customer.user_id, show_id: @subscription.show_id } }
    end

    assert_redirected_to show_url(Subscription.last)
  end

  test "should show subscription" do
    get subscription_url(@subscription)
    #assert_response :redirect
    assert_response :success
  end

  test "should get edit" do
    get edit_subscription_url(@subscription)
    #assert_response :redirect
    assert_response :success
  end

  test "should update subscription" do
    patch subscription_url(@subscription), params: { subscription: { current_episode: @subscription.current_episode, customer_id: @subscription.customer_id, show_id: @subscription.show_id } }
    #assert_redirected_to subscription_url(@subscription)
  end

  test "should destroy subscription" do
    #does not destroy subscription
    assert_difference('Subscription.count', -1) do
      delete subscription_url(@subscription)
    end

    assert_redirected_to subscriptions_url
  end
end
