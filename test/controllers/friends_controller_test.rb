require 'test_helper'

class FriendsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @friend = @customer.friends.first
    log_in_as(@customer.person)
  end
  
  test "should destroy friendship" do
    assert_difference('Friendship.count', -2) do
        delete "#{friends_path}/#{@friend.id}"
    end 
  end
end
