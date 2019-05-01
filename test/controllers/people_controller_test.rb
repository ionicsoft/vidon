require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@person)
  end

  test "should get index" do
    get people_url
    #assert_response :redirect
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    #assert_response :redirect
    assert_response :success
  end

  test "should create person" do
    #does not create person
    @customer = Customer.create
    assert_difference('Person.count', 1) do
      post people_url, params: { person: { email: "blah@gmail.com", first_name: "Joe", last_name: "Schmoe", password:"password", password_confirmation: "password", user_id: @customer.id, user_type: "Customer", username: "schmoe" } }
    end

    assert_redirected_to person_url(Person.last)
  end

  test "should show person" do
    get person_url(@person)
    #assert_response :redirect
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    #assert_response :redirect
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { email: @person.email, first_name: @person.first_name, last_name: @person.last_name, password_digest: @person.password_digest, user_id: @person.user_id, user_type: @person.user_type, username: @person.username } }
    #assert_redirected_to person_url(@person)
  end

  test "should destroy person" do
    #does not destroy person
    assert_difference('Person.count', -1) do
      delete person_url(@person)
    end

    assert_redirected_to people_url
  end
end
