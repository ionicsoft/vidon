require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end
  
  #Begin coverage testing
  test "should get home" do
    get root_url
    assert_response :success
  end

  test "should get about" do
    get about_url
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success
  end
  
  test "should get browse" do
    log_in_as_customer
    get browse_url
    assert_response :success
  end
  
  test "should get friends" do
    log_in_as_customer
    get friends_url
    assert_response :redirect
  end
  
  test "should get my rentals" do
    log_in_as_customer
    get my_rentals_url(@customer)
    assert_response :success
  end
  
  test "should get search" do
    log_in_as_customer
    #search url is undefined?
    get search_url
    assert_response :success
  end
  
  test "should get shows" do
    get shows_url
    assert_response :success
  end
  
  #Begin use cases
  test "should get login" do
    visit root_url
    click_on 'Login'
    assert_selector "h1", "Login"
  end
  
  test "should get customer signup" do
    visit root_url
    #doesn't see this?
    click_on 'Sign up today'
    assert_selector "h1", "Sign up"
  end
  
  test "should get producer signup" do
    visit root_url
    #doesn't see this?
    click_on 'Producer? Sign up here'
    assert_selector "h1", "Sign up"
  end
  
  test "should return home" do
    visit root_url
    click_on 'Vidon'
    assert_selector "span", "Vidon"
  end
end
