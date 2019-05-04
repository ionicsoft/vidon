require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  
  setup do
    @customer = customers(:one)
  end
  
  test "customer can send FR to new customer" do
    assert @customer.can_friend?(Customer.new)
  end
  
  test "customer cannot send to FR twice" do
    friend = Customer.create
    assert @customer.can_friend?(friend)
    friend.friend_requests.create(requester: @customer)
    assert_not @customer.can_friend?(friend)
  end
  
  test "customer cannot send to FR to friend" do
    friend = @customer.friends.create
    assert_not @customer.can_friend?(friend)
  end
  
end
