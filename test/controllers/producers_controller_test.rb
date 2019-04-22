require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producer = producers(:one)
    @show = shows(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  test "should get index" do
    get producers_url
    assert_response :success
  end

  test "should get new" do
    get new_producer_url
    assert_response :success
  end

  test "should create producer" do
    assert_difference('Producer.count') do
      # :company_name,:person_attributes => [:avatar, :username, :password, 
      # :password_confirmation, :email]
      @person = @producer.person
      post producers_url, params: { producer: {
        company_name: @producer.company_name,
        person_attributes: {
          username: "producername",
          password: "123456",
          password_confirmation:
          "123456",
          email: @person.email
      } } }
    end

    # assert_redirected_to producer_url(Producer.last)
  end

  test "should show producer" do
    log_in_as @producer.person
    get producer_url(@producer)
    assert_response :success
  end

  test "should get edit" do
    log_in_as @producer.person
    get edit_producer_url(@producer)
    assert_response :success
  end

  test "should update producer" do
    log_in_as @producer.person
    patch producer_url(@producer), params: { producer: { company_name: @producer.company_name } }
    assert_redirected_to producer_url(@producer)
  end

  test "should destroy producer" do
    log_in_as @producer.person
    assert_difference('Producer.count', -1) do
      delete producer_url(@producer)
    end

    assert_redirected_to producers_url
  end
  
  test "should get shows" do
    log_in_as(@producer.person)
    click_on 'My Shows'
    assert_redirected_to pro_show_path
  end
  
  test "should get profile" do
    log_in_as(@producer.person)
    click_on @producer.company_name
    click_on 'Profile'
    assert_redirected_to producer_url(@producer)
  end
  
  test "should get settings" do
    log_in_as(@producer.person)
    click_on @producer.company_name
    click_on 'Settings'
    assert_redirected_to edit_producer_path(@producer)
  end
  
  test "should log out" do
    log_in_as(@producer.person)
    click_on @producer.company_name
    click_on 'Log out'
    assert_redirected_to root_url
  end
  
  test "should get show content page" do
    log_in_as(@producer.person)
    click_on 'View Show'
    assert_redirected_to show_url(@show)
  end
  
  test "should get movie content page" do
    log_in_as(@producer.person)
    click_on 'View Movie'
    assert_redirected_to movie_url
  end
  
  test "should get add show form" do
    log_in_as(@producer.person)
    click_on 'Add New Show'
    assert_redirected_to new_show_url
  end
  
  test "should get add movie form" do
    log_in_as(@producer.person)
    click_on 'Add New Movie'
    assert_redirected_to new_movie_url
  end
  
  test "should get add episode form" do
    log_in_as(@producer.person)
    click_on 'View Show'
    click_on 'Add Episode'
    assert_redirected_to new_episode_url
  end
  
  test "should get show from profile" do
    log_in_as(@producer.person)
    click_on @producer.company_name
    click_on 'Profile'
    click_on 'Show'
    assert_redirected_to show_show_url
  end
  
  test "should get movie from profile" do
    log_in_as(@producer.person)
    click_on @producer.company_name
    click_on 'Profile'
    click_on 'Movie'
    assert_redirected_to show_movie_url
  end
end
