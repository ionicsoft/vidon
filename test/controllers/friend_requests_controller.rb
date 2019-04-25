require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @customer = customers(:three)
        @customer2 = customer(:four)
        @req = friend_requests(:one)
        Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(app, :browser => :firefox)
        end
    end
    test "should create friend request" do     
        assert_difference('FriendRequest.count', 1) do
            post friend_request_url, params: { customer_id: @customer.id, requester_id: @customer2.id }
        end 
    end
    
    test "should update friend request" do
        #todo
    end
    
    test "should destroy friend request" do
        assert_difference('FriendRequest.count', -1) do
            delete friend_request_url(@req)
        end
    end
end