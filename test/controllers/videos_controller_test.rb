require 'test_helper'

class VideosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video = videos(:one)
    @producer = @video.content.show.producer
    @customer = customers(:one)
  end

  test "should show video" do
    log_in_as(@producer.person)
    get video_url(@video)
    assert_response :success
  end
  
  test "should show video for customer" do
    log_in_as(@customer.person)
    get video_url(@video)
  end
  
  test "should show movie video" do
    temp = movies(:one)
    log_in_as(@customer.person)
    get video_url(temp.video)
  end
  
  test "should check for subscription" do
    temp = videos(:three)
    log_in_as(@customer.person)
    get video_url(temp)
  end
  
  test "should check for rental" do
    temp = movies(:two)
    log_in_as(@customer.person)
    get video_url(temp.video)
  end
  
  test "should assert movie" do
    log_in_as(@producer.person)
    vid = videos(:six)
    assert vid.movie? == true
  end
  
  test "should get movie genres" do
    log_in_as(@producer.person)
    vid = videos(:six)
    genres = vid.get_content_genres
    assert !genres.nil?
  end
  
  test "should redirect if not correct producer" do
    temp = producers(:two)
    log_in_as(temp.person)
    get video_url(@video)
  end
  
  test "should validate subscription before viewing" do
    sub = @customer.subscriptions.find_by(show: @video.content.show)
    sub.update_attribute(:current_episode, 0)
    log_in_as(@customer.person)
    get video_url(@video)
  end
  
  test "should update watch history" do
    temp = videos(:two)
    log_in_as(@customer.person)
    get video_url(temp)
  end
end
