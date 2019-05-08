require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @file = fixture_file_upload("files/test.mp4","video/mp4")
    @video = videos(:one)
    @producer = @video.content.show.producer
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@producer.person)
  end

  test "should show video" do
    get video_url(@video)
    #assert_response :redirect
    assert_response :success
  end
end
