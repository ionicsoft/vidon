require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @customer = customers(:three)
        @customer2 = customers(:four)
        @req = friend_requests(:one)
        Capybara.register_driver :selenium do |app|
            Capybara::Selenium::Driver.new(app, :browser => :firefox)
        end
        log_in_as(@customer.person)
    end
    test "should create friend request" do     
        assert_difference('FriendRequest.count', 1) do
            post friend_requests_url, params: { friend_request: {customer_id: @customer.id, requester_id: @customer2.id }}
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
    
    test "should accept pending request" do
        post friend_requests_url, params: { friend_request: {customer_id: @customer.id, requester_id: @customer2.id }}
        log_in_as @customer2.person
        assert_difference ->{ FriendRequest.count } => -1, ->{ @customer.friends.count } => 1 do
            post friend_requests_url, params: { friend_request: {customer_id: @customer2.id, requester_id: @customer.id }}
        end
    end
end