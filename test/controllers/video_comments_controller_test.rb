require 'test_helper'

class VideoCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video_comment = video_comments(:one)
    @customer = @video_comment.customer.person
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@customer)
  end

  test "should get index" do
    get video_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_video_comment_url
    #assert_response :redirect
    assert_response :success
  end

  test "should create video_comment" do
    #does not create comment
    assert_difference('VideoComment.count', 1) do
      post video_comments_url, params: { video_comment: { comment: "yo", customer_id: @customer.id, video_id: @video_comment.video_id } }
    end

    assert_redirected_to video_comment_url(VideoComment.last)
  end

  test "should show video_comment" do
    get video_comment_url(@video_comment)
    #assert_response :redirect
    assert_response :success
  end

  test "should get edit" do
    get edit_video_comment_url(@video_comment)
    #assert_response :redirect
    assert_response :success
  end

  test "should update video_comment" do
    patch video_comment_url(@video_comment), params: { video_comment: { comment: @video_comment.comment, customer_id: @video_comment.customer_id, video_id: @video_comment.video_id } }
    #assert_redirected_to video_comment_url(@video_comment)
  end

  test "should destroy video_comment" do
    #does not destroy comment
    assert_difference('VideoComment.count', -1) do
      delete video_comment_url(@video_comment)
    end

    assert_redirected_to video_comments_url
  end
end
