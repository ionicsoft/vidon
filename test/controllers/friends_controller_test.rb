require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @friend = friendships(:one)
    Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end 
  end
  
  test "should destroy friendship" do
    assert_difference('FriendRequest.count', -1) do
        delete friendship_url(@friend)
    end 
  end
end
