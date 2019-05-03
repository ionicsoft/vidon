require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
    @customer = customers(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  test "should create subscription" do
    temp = Customer.first.person
    log_in_as(temp)
    assert_difference('Subscription.count', 1) do
      post subscriptions_url, params: { subscription: { current_episode: 1, customer_id: temp.user_id, show_id: @subscription.show_id } }, headers: { 'HTTP_REFERER' => @subscription.show }
    end

    assert_redirected_to @subscription.show
  end

  test "should update subscription" do
    log_in_as(@customer.person)
    patch subscription_url(@subscription), params: { subscription: { current_episode: @subscription.current_episode, customer_id: @subscription.customer_id, show_id: @subscription.show_id } }
    assert_redirected_to "/"
  end
  
  test "should return next episode" do
    log_in_as(@customer.person)
    temp =  @subscription.next_video
    assert temp.content_type == "Episode"
  end
  
  test "should purchase additional slot" do
    @customer.update_attribute(:slots, 0)
    log_in_as_customer
    click_on 'Browse'
    show2 = shows(:two)
    click_on show2.name
    first(:button, 'Subscribe').click
    assert_difference('@customer.slots', 1) do
      click_on "Purchase", class: "btn-warning"
      #slot is purchased, but customer does not save
    end
  end
end
