require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end
  
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
  
  test "should get login" do
    get root_url
    click_on 'Login'
    assert_response :success
  end
  
  test "should get customer signup" do
    get root_url
    click_on 'Sign up today'
    assert_redirected_to new_customer_url
  end
  
  test "should get producer signup" do
    visit root_url
    click_on 'Producer? Sign up today'
    assert_redirected_to new_producer_url
  end
  
  test "should return home" do
    visit root_url
    click_on 'Vidon'
    assert_redirected_to root_url
  end
end
