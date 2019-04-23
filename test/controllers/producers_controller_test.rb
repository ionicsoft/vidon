require 'test_helper'

class ProducersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @producer = producers(:one)
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
end
