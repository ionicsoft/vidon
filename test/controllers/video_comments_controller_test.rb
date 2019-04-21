require 'test_helper'

class VideoCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_comment = video_comments(:one)
    @customer = @video_comment.customer.person
  end

  test "should get index" do
    log_in_as @customer
    get video_comments_url
    assert_response :success
  end

  test "should get new" do
    log_in_as @customer
    get new_video_comment_url
    assert_response :success
  end

  # test "should create video_comment" do
  #   log_in_as @customer
  #   assert_difference('VideoComment.count') do
  #     post video_comments_url, params: { video_comment: { comment: @video_comment.comment, customer_id: @video_comment.customer_id, video_id: @video_comment.video_id } }
  #   end

  #   assert_redirected_to video_comment_url(VideoComment.last)
  # end

  test "should show video_comment" do
    log_in_as @customer
    get video_comment_url(@video_comment)
    assert_response :success
  end

  test "should get edit" do
    log_in_as @customer
    get edit_video_comment_url(@video_comment)
    assert_response :success
  end

  test "should update video_comment" do
    log_in_as @customer
    patch video_comment_url(@video_comment), params: { video_comment: { comment: @video_comment.comment, customer_id: @video_comment.customer_id, video_id: @video_comment.video_id } }
    assert_redirected_to video_comment_url(@video_comment)
  end

  # test "should destroy video_comment" do
  #   log_in_as @customer
  #   assert_difference('VideoComment.count', -1) do
  #     delete video_comment_url(@video_comment)
  #   end

  #   assert_redirected_to video_comments_url
  # end
end
