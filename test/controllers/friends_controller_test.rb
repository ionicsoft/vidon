require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @friend = friendships(:one)
    Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as_customer
  end
  
  test "should destroy friendship" do
    assert_difference('FriendRequest.count', -1) do
        #not sure how to remove friend here
        delete friend_url(@friend)
    end 
  end
end
