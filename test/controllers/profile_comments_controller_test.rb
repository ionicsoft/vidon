require 'test_helper'

class ProfileCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_comment = profile_comments(:one)
    @customer = Customer.first.person
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as_customer
  end

  test "should get index" do
    get profile_comments_url
    assert_response :redirect
    #assert_response :success
  end

  test "should get new" do
    get new_profile_comment_url
    assert_response :redirect
    #assert_response :success
  end

  test "should create profile_comment" do
    #does not create comment
    assert_difference('ProfileComment.count', 1) do
      get customer_url(@profile_comment.customer)
      post profile_comments_url, params: { profile_comment: { comment: @profile_comment.comment, commentor_id: @profile_comment.commentor_id, customer_id: @profile_comment.customer_id } }, headers: { 'HTTP_REFERER' => customer_url(@profile_comment.customer) }
    end

    assert_redirected_to customer_url(@profile_comment.customer)
  end

  test "should show profile_comment" do
    get profile_comment_url(@profile_comment)
    assert_response :redirect
    #assert_response :success
  end

  test "should get edit" do
    get edit_profile_comment_url(@profile_comment)
    assert_response :redirect
    #assert_response :success
  end

  test "should update profile_comment" do
    get customer_url(@profile_comment.customer)
    patch profile_comment_url(@profile_comment), params: { profile_comment: { comment: @profile_comment.comment, commentor_id: @profile_comment.commentor_id, customer_id: @profile_comment.customer_id } }
    assert_redirected_to profile_comment_url(@profile_comment)
  end

  test "should destroy profile_comment" do
    #does not destroy comment
    assert_difference('ProfileComment.count', -1) do
      delete profile_comment_url(@profile_comment)
    end

    assert_redirected_to profile_comments_url
  end
end
