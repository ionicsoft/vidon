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
    assert_equal "Profile comment was successfully created.", flash[:notice]
  end
  
  test "should not create empty profile_comment" do
    assert_difference('ProfileComment.count', 0) do
      get customer_url(@profile_comment.customer)
      post profile_comments_url, params: { profile_comment: { comment: "", commentor_id: @customer.id, customer_id: @profile_comment.customer_id } }, headers: { 'HTTP_REFERER' => customer_url(@profile_comment.customer) }
    end

    assert_redirected_to customer_url(@profile_comment.customer)
    assert_equal "Failed to create comment.", flash[:notice]
  end

  test "should update profile_comment" do
    get customer_url(@profile_comment.customer)
    patch profile_comment_url(@profile_comment), params: { profile_comment: { comment: @profile_comment.comment, commentor_id: @profile_comment.commentor_id, customer_id: @profile_comment.customer_id } }, headers: { 'HTTP_REFERER' => customer_url(@profile_comment.customer) }
    
    assert_redirected_to customer_url(@profile_comment.customer)
    assert_equal "Profile comment was successfully updated.", flash[:notice]
  end
  
  test "should not update profile_comment with invalid data" do
    get customer_url(@profile_comment.customer)
    patch profile_comment_url(@profile_comment), params: { profile_comment: { comment: "", commentor_id: @profile_comment.commentor_id, customer_id: @profile_comment.customer_id } }, headers: { 'HTTP_REFERER' => customer_url(@profile_comment.customer) }
    
    assert_redirected_to customer_url(@profile_comment.customer)
    assert_equal "Failed to update comment.", flash[:notice]
  end

  test "should destroy profile_comment" do
    assert_difference('ProfileComment.count', -1) do
      delete profile_comment_url(@profile_comment)
    end

    assert_redirected_to profile_comments_url
  end
end
