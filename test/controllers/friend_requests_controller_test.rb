require 'test_helper'

class FriendRequestsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @customer = customers(:three)
        @customer2 = customers(:four)
        @temp = customers(:one)
        @req = friend_requests(:two)
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
    
    test "should not friend request oneself" do
        assert_difference('FriendRequest.count', 0) do
            post friend_requests_url, params: { friend_request: {customer_id: @customer.id, requester_id: @customer.id }}
        end 
    end
    
    test "should update friend request" do
        assert_difference('FriendRequest.count', -1) do
            patch friend_request_url(@req), params: { friend_request: {customer_id: @customer.id, requester_id: @temp.id }}
        end
    end
    
    test "should destroy friend request" do
        assert_difference('FriendRequest.count', -1) do
            delete friend_request_url(@req)
        end
    end
    
    test "should accept pending request" do
        c1 = customers(:three)
        c2 = customers(:four)
        assert_difference 'FriendRequest.count', 1 do
            post friend_requests_path, params: { friend_request: {customer_id: c2.id, requester_id: c1.id }}
        end
        assert_difference 'FriendRequest.count', -1 do
           assert_difference 'c1.friends.count', 1 do
                post friend_requests_path, params: { friend_request: {customer_id: c1.id, requester_id: c2.id }}
           end
        end
    end
end