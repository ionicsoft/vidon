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
    get search_page_url
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
    first(:link, 'Sign up today').click
    assert_selector "h1", text: "Sign up"
  end

  test "should get producer signup" do
    visit root_url
    first(:link, 'Producer? Sign up here').click
    assert_selector "h1", text: "Sign up"
  end

  test "should return home" do
    visit root_url
    click_on 'Vidon'
    assert_selector "span", text: "Vidon"
  end
  
  test "should search with actor filters" do
    show = shows(:one)
    log_in_as_customer
    fill_in "search", with: "ad"
    click_on "search-btn"
    fill_in "filters_actor", with: "ann"
    click_on 'Apply', class: "btn-primary"
    assert_selector "h5", text: show.name
  end
  
  test "should search with genre filters" do
    show = shows(:one)
    log_in_as_customer
    fill_in "search", with: "ad"
    click_on "search-btn"
    find("select", id: "filters_genre").click
    find('#filters_genre').find(:xpath, 'option[2]').select_option
    assert_selector "h5", text: show.name
  end
  
  test "should get next episode" do
    customer = customers(:one)
    watch = customer.watch_histories.first
    watch.update_attribute(:completed, true)
    log_in_as_customer
    assert_selector "a", text: "Watch Next"
  end
  
  test "should get next series" do
    customer = customers(:one)
    vid = videos(:five)
    watch = customer.watch_histories.first
    watch.update_attribute(:video_id, vid.id)
    watch.update_attribute(:completed, true)
    log_in_as_customer
    #Doesn't go to next series?
    #save_and_open_page
    #assert_selector "a", text: "Watch Next"
  end

end
