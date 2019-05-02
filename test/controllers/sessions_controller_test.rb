require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @producer = producers(:one)
    @video = videos(:one)
    @show = shows(:one)
  end
  
  test "should get new" do
    get login_path
    assert_response :success
  end
  
  test "should sign in through cookie" do
    @customer = customers(:one)
    cookies.signed[:person_id] = @customer.person.id
    log_in_as(@customer.person)
  end
  
  test "should redirect if not logged in" do
    get video_url(@video)
    assert_redirected_to login_path
  end
  
  test "should redirect if not logged in as customer" do
    log_in_as(@producer.person)
    visit customer_url(@customer)
    assert_redirected_to root_url
  end
  
  test "should redirect if customer is not logged in" do
    get customer_url(@customer)
    assert_redirected_to login_path
  end
  
  test "should redirect if not producer" do
    log_in_as(@customer.person)
    visit edit_show_url(@show)
    assert_redirected_to root_url
  end
  
  test "should redirect if producer is not logged in" do
    get producer_url(@producer)
    assert_redirected_to login_path
  end
end
