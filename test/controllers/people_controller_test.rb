require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@person)
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

end
