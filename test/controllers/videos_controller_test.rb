require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video = videos(:one)
    @producer = @video.content.show.producer
    log_in_as(@producer.person)
  end

  test "should show video" do
    get video_url(@video)
    assert_response :success
  end
end
