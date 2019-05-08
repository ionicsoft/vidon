require 'test_helper'

class VideoCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_comment = video_comments(:one)
    @video = videos(:one)
    @customer = @video_comment.customer.person
  end

  test "should create video_comment" do
    log_in_as(@customer)
    assert_difference('VideoComment.count', 1) do
      post video_comments_url, params: { video_comment: { comment: "yo", customer_id: @customer.id, video_id: @video_comment.video_id } }, headers: { 'HTTP_REFERER' => @video }
    end

    assert_redirected_to @video
  end
  
  test "should not create invalid video comment" do
    log_in_as(@customer)
    assert_difference('VideoComment.count', 0) do
      post video_comments_url, params: { video_comment: { comment: "yo", customer_id: @customer.id, video_id: @video_comment.video_id + 1} }, headers: { 'HTTP_REFERER' => @video }
    end
  end

  test "should update video_comment" do
    log_in_as(@customer)
    patch video_comment_url(@video_comment), params: { video_comment: { comment: @video_comment.comment, customer_id: @video_comment.customer_id, video_id: @video_comment.video_id } }
    assert_redirected_to video_comment_url(@video_comment)
  end
  
  test "should not update invalid comment" do
    log_in_as(@customer)
    patch video_comment_url(@video_comment), params: { video_comment: { comment: @video_comment.comment, customer_id: @video_comment.customer_id, video_id: @video_comment.video_id + 1 } }
  end

  test "should destroy video_comment" do
    log_in_as(@customer)
    assert_difference('VideoComment.count', -1) do
      delete video_comment_url(@video_comment), headers: { 'HTTP_REFERER' => @video }
    end

    assert_redirected_to @video
  end
  
  test "should not destroy another person's comment" do
    temp = customers(:two)
    log_in_as(temp.person)
    assert_difference('VideoComment.count', 0) do
      delete video_comment_url(@video_comment), headers: { 'HTTP_REFERER' => @video }
    end
  end
end
