require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @friend = friendships(:one)
    @customer = customers(:one)
    Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@customer.person)
  end
  
  test "should destroy friendship" do
    assert_difference('Friendship.count', -1) do
        #not sure how to remove friend here
        delete friendship_url(@friend)
    end 
  end
end
