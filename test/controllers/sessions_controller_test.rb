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
  
  test "login with invalid data" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { username: "", password: "" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get login_path
    assert flash.empty?
  end
  
  test "login and logout" do
    get login_path
    post login_path, params: { session: { username: "bob", password: "password" } }
    assert is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/_home_customer'
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    delete logout_path
    follow_redirect!
  end
  
  test "login with remember" do
    log_in_as(@customer.person, remember_me: 1)
    assert_not_empty cookies[:remember_token]
  end
  
  test "login without remember" do
    log_in_as(@customer.person, remember_me: 1)
    log_in_as(@customer.person, remember_me: 0)
    assert_empty cookies[:remember_token]
  end
  
  test "should redirect if not logged in" do
    get video_url(@video)
    assert_redirected_to login_path
  end
  
  test "should redirect if not logged in as customer" do
    log_in_as(@producer.person)
    get friends_url(@customer)
    assert_redirected_to root_url
  end
  
  test "should redirect if customer is not logged in" do
    get friends_url(@customer)
    assert_redirected_to login_path
  end
  
  test "should redirect if not producer" do
    log_in_as(@customer.person)
    visit edit_show_url(@show)
    assert_redirected_to root_url
  end
  
  test "should redirect if producer is not logged in" do
    #need to test else part of logged_in_producer
    get producer_url(@producer)
    assert_redirected_to login_path
  end
end
