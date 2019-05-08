require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  test "should get edit" do
    log_in_as(@person)
    get edit_person_url(@person)
    assert_response :success
  end
  
  test "should not get edit for other person" do
    log_in_as(people(:three))
    get edit_person_url(@person)
    assert_redirected_to root_url
  end

  test "should update person" do
    log_in_as(@person)
    get edit_person_url(@person)
    patch person_url(@person), params: { 
      person: { 
        email: @person.email,
        first_name: @person.first_name,
        last_name: @person.last_name,
        password: "password",
        password_confirmation: "password"
      } 
    }
    
    assert_redirected_to @person.user
  end
  
  test "should update without password" do
    log_in_as(@person)
    get edit_person_url(@person)
    patch person_url(@person), params: { 
      person: { 
        email: @person.email,
        first_name: @person.first_name,
        last_name: @person.last_name
      } 
    }
    
    assert_redirected_to @person.user
  end
  
  test "should not update with invalid password" do
    log_in_as(@person)
    get edit_person_url(@person)
    patch person_url(@person), params: { 
      person: { 
        email: @person.email,
        first_name: @person.first_name,
        last_name: @person.last_name,
        password: "123",
        password_confirmation: "123"
      } 
    }
    
    assert_template 'people/edit'
  end
  
  test "should get default picture" do
    customer = customers(:four)
    log_in_as_customer
    visit customer_url(customer)
    find("img[src*=default_profile]")
  end

end
