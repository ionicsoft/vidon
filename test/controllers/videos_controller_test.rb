require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video = videos(:one)
    @producer = @video.content.show.producer.person
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as_producer
  end

  test "should get index" do
    get videos_url
    assert_response :success
  end

  test "should get new" do
    get new_video_url
    assert_response :success
  end

  test "should create video" do
    #does not create video
    assert_difference('Video.count', 1) do
      post videos_url, params: { video: { description: @video.description, title: @video.title } }
    end

    assert_redirected_to video_url(Video.last)
  end

  test "should show video" do
    get video_url(@video)
    assert_response :redirect
    #assert_response :success
  end

  test "should get edit" do
    get edit_video_url(@video)
    assert_response :redirect
    #assert_response :success
  end

  test "should update video" do
    patch video_url(@video), params: { video: { description: @video.description, title: @video.title } }
    #assert_redirected_to video_url(@video)
  end

  test "should destroy video" do
    #does not destroy video
    assert_difference('Video.count', -1) do
      delete video_url(@video)
    end

    assert_redirected_to videos_url
  end
end
