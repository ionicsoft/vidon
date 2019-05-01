require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @friend = @customer.friends.first
    Capybara.register_driver :selenium do |app|
        Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@customer.person)
  end
  
  test "should destroy friendship" do
    assert_difference('Friendship.count', -2) do
        #not sure how to remove friend here
        delete "#{friends_path}/#{@friend.id}"
    end 
  end
end
