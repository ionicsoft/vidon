require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producer = producers(:one)
    @show = shows(:one)
    @movie = movies(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as_producer
  end

  #Begin coverage testing
  test "should get index" do
    get producers_url
    assert_response :success
  end

  test "should get new" do
    get new_producer_url
    assert_response :success
  end

  test "should create producer" do
    assert_difference('Producer.count', 1) do
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

    assert_redirected_to producer_url(Producer.last)
  end

  test "should show producer" do
    get producer_url(@producer)
    assert_response :success
  end

  test "should get edit" do
    get edit_producer_url(@producer)
    assert_response :redirect
    #assert_response :success
  end

  test "should update producer" do
    patch producer_url(@producer), params: { producer: { company_name: @producer.company_name } }
    #assert_redirected_to producer_url(@producer)
  end

  test "should destroy producer" do
    #does not destroy producer
    assert_difference('Producer.count', -1) do
      delete producer_url(@producer)
    end

    assert_redirected_to producers_url
  end
  
  #Begin use cases
  test "should get shows" do
    click_on 'My Shows'
    assert_selector "h3", "My Shows"
  end

  test "should get profile" do
    click_on @producer.company_name
    click_on 'Profile'
    assert_selector "h2", @producer.company_name
  end

  test "should get settings" do
    click_on @producer.company_name
    click_on 'Settings'
    assert_selector "h1", "Edit Information"
  end

  test "should log out" do
    click_on @producer.company_name
    click_on 'Log out'
    assert_selector "h2", "Say hello to subscriptions."
  end

  test "should get show content page" do
    click_on 'View Show'
    assert_selector "h1", @show.name
  end

  test "should get movie content page" do
    click_on 'View Movie'
    assert_selector "h1", @movie.video.title
  end

  test "should get add show form" do
    click_on 'Add New Show'
    assert_selector "h1", "Create Show"
  end

  test "should get add movie form" do
    click_on 'Add New Movie'
    assert_selector "h1", "Create Movie"
  end

  test "should get add episode form" do
    click_on 'View Show'
    click_on 'Add Episode'
    assert_selector "h1", "Create Episode"
  end

  test "should get show from profile" do
    click_on @producer.company_name
    click_on 'Profile'
    click_on @show.name
    assert_selector "h1", @show.name
  end

  test "should get movie from profile" do
    click_on @producer.company_name
    click_on 'Profile'
    click_on @movie.video.title
    assert_selector "h1", @movie.video.title
  end
end
