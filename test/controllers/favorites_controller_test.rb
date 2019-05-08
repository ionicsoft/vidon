require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video = videos(:two)
    @video2 = videos(:six)
    @customer = customers(:one)
    @favorite = favorites(:one)
    log_in_as(@customer.person)
  end
  
  test "should create favorite episode" do
    assert_difference('Favorite.count', 1) do
      post favorites_url, params: { customer_id: @customer.id, favorite: { content_id: 
        @video.content_id, content_type: "Episode" }  }, headers: { 'HTTP_REFERER' => @customer }
    end
  end
  
  test "should create favorite movie" do
    assert_difference('Favorite.count', 1) do
      post favorites_url, params: { customer_id: @customer.id, favorite: { content_id: 
        @video2.content_id, content_type: "Movie" } }, headers: { 'HTTP_REFERER' => @customer }
    end
  end
  
  test "should destroy favorite" do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(@favorite), headers: { 'HTTP_REFERER' => @customer }
    end
  end
end
