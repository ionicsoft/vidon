require 'test_helper'

class ProfileCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_comment = profile_comments(:one)
    @customer = customers(:one).person
    log_in_as(@customer)
  end

  test "should create profile_comment" do
    assert_difference('ProfileComment.count', 1) do
      get customer_url(@profile_comment.customer)
      post profile_comments_url, params: { profile_comment: { comment: "yo", commentor_id: @customer.id, customer_id: @profile_comment.customer_id } }, headers: { 'HTTP_REFERER' => customer_url(@profile_comment.customer) }
    end

    assert_redirected_to customer_url(@profile_comment.customer)
  end

  test "should update profile_comment" do
    get customer_url(@profile_comment.customer)
    patch profile_comment_url(@profile_comment), params: { profile_comment: { comment: @profile_comment.comment, commentor_id: @profile_comment.commentor_id, customer_id: @profile_comment.customer_id } }
    assert_redirected_to profile_comment_url(@profile_comment)
  end

  test "should destroy profile_comment" do
    assert_difference('ProfileComment.count', -1) do
      delete profile_comment_url(@profile_comment)
    end

    assert_redirected_to profile_comments_url
  end
end
