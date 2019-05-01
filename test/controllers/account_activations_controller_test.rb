require 'test_helper'

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
  end
  test "should activate account" do
    temp = Person.create(username: "yolo", first_name: "joe", last_name: "targayen", email: "blah@gmail.com", password: "1234")
    temp.update_attribute(:activated, true)
    get edit_account_activation_url(temp)
    assert_redirected_to root_url
  end
end
