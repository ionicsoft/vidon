require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @producer = producers(:one)
    @video = videos(:one)
    @show = shows(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
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
  
  test "should refuse login for incorrect password" do
    visit root_url
    click_on 'Login'
    fill_in "Username", with: @customer.person.username
    fill_in "Password", with: "blah"
    click_on "Login", class: "btn-primary"
    find(:button, class: "close")
  end
  
  test "should destroy session" do
    log_in_as_customer
    delete logout_url(@customer)
    assert_redirected_to root_url
  end
  
  test "should destroy nonexistent session" do
    delete logout_url(@customer)
    assert_redirected_to root_url
  end
  
  test "should refuse unauthenticated account" do
    visit signup_url
    fill_in "person_username", with: "steve"
    fill_in "person_password", with: "steveee"
    fill_in "person_password_confirmation", with: "steveee"
    fill_in "person_email", with: "steve-o@gmail.com"
    fill_in "person_first_name", with: "Steve"
    fill_in "person_last_name", with: "Harvey"
    fill_in "payment_card_name", with: "Steve Harvey"
    fill_in "payment_card_num", with: "1111222233334444"
    fill_in "payment_cvc", with: 123
    find('#customer_payment_attributes_expiration_2i').find(:xpath, 'option[10]').select_option
    click_on "Submit!"
    fill_in "Username", with: "steve"
    fill_in "Password", with: "steveee"
    click_on "Login", class: "btn-primary"
    find(:button, class: "close")
  end
end
