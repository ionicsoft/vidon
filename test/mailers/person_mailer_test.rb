require 'test_helper'

class PersonMailerTest < ActionMailer::TestCase
  test "account_activation" do
    @person = Customer.create(
      person_attributes: {
        username: "foo",
        password: "password",
        password_confirmation: "password",
        first_name: "Foo",
        last_name: "Bar",
        email: "testemail@exmaple.com"
      }
    ).person
    mail = PersonMailer.account_activation @person
    assert_equal "Account activation", mail.subject
    assert_equal [@person.email], mail.to
    assert_equal ["noreply@ionicsoft-vidon.herokuapp.com"], mail.from
    assert_includes mail.body.encoded, CGI.escape(@person.email)
  end

  test "sub_notice" do
    @person = people(:one)
    mail = PersonMailer.sub_notice @person
    assert_equal "Subscription notice", mail.subject
    assert_equal [@person.email], mail.to
    assert_equal ["noreply@ionicsoft-vidon.herokuapp.com"], mail.from
    assert_includes mail.body.encoded, "renew"
  end

end
