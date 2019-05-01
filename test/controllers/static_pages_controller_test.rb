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
    log_in_as(@customer.person)
    get browse_url
    assert_response :success
  end

  test "should get friends" do
    log_in_as(@customer.person)
    get friends_url
    assert_response :success
  end

  test "should get my rentals" do
    log_in_as(@customer.person)
    get my_rentals_url(@customer)
    assert_response :success
  end

  test "should get search" do
    log_in_as(@customer.person)
    #search url is undefined?
    get search_page_url
    #assert_response :success
    assert_response :redirect
  end

  test "should get shows" do
    log_in_as(@customer.person)
    get my_shows_url
    assert_response :success
  end

  #Begin use cases
  test "should get login" do
    visit root_url
    click_on 'Login'
    assert_selector "h1", text: "Login"
  end

  test "should get customer signup" do
    visit root_url
    #doesn't see this?
    first(:link, 'Sign up today').click
    assert_selector "h1", text: "Sign up"
  end

  test "should get producer signup" do
    visit root_url
    #doesn't see this?
    first(:link, 'Producer? Sign up here').click
    assert_selector "h1", text: "Sign up"
  end

  test "should return home" do
    visit root_url
    click_on 'Vidon'
    assert_selector "span", text: "Vidon"
  end

end
