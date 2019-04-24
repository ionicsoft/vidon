require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @video = videos(:two)
    @video2 = videos(:six)
    @customer = customers(:one)
    @favorite = favorites(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end
  
  test "should create favorite episode" do
    assert_difference('Favorite.count', 1) do
      post favorites_url, params: { customer_id: @customer.id, movie: { video_attributes: { content_id: 
        @video.content_id, content_type: @video.content_type } } }
    end
  end
  
  test "should create favorite movie" do
    assert_difference('Favorite.count', 1) do
      post favorites_url, params: { customer_id: @customer.id, movie: { video_attributes: { content_id: 
        @video2.content_id, content_type: @video2.content_type } } }
    end
  end
  
  test "should destroy favorite" do
    assert_difference('Favorite.count', -1) do
      delete favorite_url(@favorite)
    end
  end
end
