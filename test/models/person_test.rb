require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = Person.new(username: "user", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @person.authenticated?(:remember, '')
  end
end
