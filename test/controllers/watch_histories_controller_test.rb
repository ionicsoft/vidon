require 'test_helper'

class WatchHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @customer = customers(:one)
    @video = videos(:two)
    log_in_as(@customer.person)
  end
  
  test "should get watch history" do
    get watch_histories_url
    assert_response :success
  end
  
  test "should update watch history" do
    patch watch_history_url(@customer), params: { watch_history: { video_id: @video.id, progress: 50 } }
  end
  
  test "should not update another person's watch history" do
    temp = customers(:two)
    patch watch_history_url(temp), params: { watch_history: { video_id: @video.id, progress: 50 } }
  end
end
