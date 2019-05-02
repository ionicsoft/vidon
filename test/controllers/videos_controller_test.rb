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
  
  test "should assert movie" do
    vid = videos(:six)
    assert vid.movie? == true
  end
  
  test "should get movie genres" do
    vid = videos(:six)
    genres = vid.get_content_genres
    assert !genres.nil?
  end
end
