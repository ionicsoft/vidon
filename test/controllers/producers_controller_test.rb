require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producer = producers(:one)
    @show = shows(:one)
    @movie = movies(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  #Begin coverage testing

  test "should get new" do
    log_in_as(@producer.person)
    get new_producer_url
    assert_response :success
  end

  test "should create producer" do
    assert_difference('Producer.count', 1) do
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

    assert_redirected_to login_path
    assert_equal 'Please check your email to activate your account.', flash[:notice]
  end
  
  test "should not create producer with invalid data" do
    assert_difference('Producer.count', 0) do
      post producers_url, params: { producer: {
        company_name: ""
      } }
    end
  
    assert_template 'producers/new'
  end

  test "should show producer" do
    log_in_as(@producer.person)
    get producer_url(@producer)
    assert_response :success
  end

  test "should destroy producer" do
    log_in_as(@producer.person)
    assert_difference('Producer.count', -1) do
      delete producer_url(@producer)
    end

    assert_redirected_to producers_url
  end
  
  test "should not destroy other producer" do
    log_in_as(producers(:two).person)
    assert_difference('Producer.count', 0) do
      delete producer_url(@producer)
    end

    assert_redirected_to root_url
  end
  
  #Begin use cases
  test "should get shows" do
    log_in_as_producer
    click_on 'My Shows'
    assert_selector "h3", text: "My Shows"
  end

  test "should get profile" do
    log_in_as_producer
    click_on @producer.company_name
    click_on 'Profile'
    assert_selector "h2", text: @producer.company_name
  end

  test "should get settings" do
    log_in_as_producer
    click_on @producer.company_name
    click_on 'Settings'
    assert_selector "h1", text: "Edit Information"
  end

  test "should log out" do
    log_in_as_producer
    click_on @producer.company_name
    click_on 'Log out'
    assert_selector "h2", text: "Say hello to subscriptions."
  end

  test "should get show content page" do
    log_in_as_producer
    click_on 'View Show'
    assert_selector "h1", text: @show.name
  end

  test "should get movie content page" do
    log_in_as_producer
    click_on 'View Movie'
    assert_selector "h1", text: @movie.video.title
  end

  test "should get add show form" do
    log_in_as_producer
    click_on 'Add New Show'
    assert_selector "h1", text: "Create Show"
  end

  test "should get add movie form" do
    log_in_as_producer
    click_on 'Add New Movie'
    assert_selector "h1", text: "Create New Movie"
  end

  test "should get add episode form" do
    log_in_as_producer
    click_on 'View Show'
    click_on 'Add episode'
    assert_selector "h1", text: "Create Episode"
  end

  test "should get show from profile" do
    log_in_as_producer
    click_on @producer.company_name
    click_on 'Profile'
    click_on @show.name
    assert_selector "h1", text: @show.name
  end

  test "should get movie from profile" do
    log_in_as_producer
    click_on @producer.company_name
    click_on 'Profile'
    click_on @movie.video.title
    assert_selector "h1", text: @movie.video.title
  end
end
