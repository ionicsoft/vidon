require 'test_helper'

class ShowRatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show_rating = show_ratings(:one)
    @customer = Customer.first.person
    log_in_as(@customer)
  end

  test "should create show_rating" do
    assert_difference('ShowRating.count', 1) do
      post show_ratings_url, params: { show_rating: { rating: 5, show_id: @show_rating.show_id, customer_id: @customer.id } }
      post show_ratings_url, params: { show_rating: { rating: 1, show_id: @show_rating.show_id, customer_id: @customer.id } }
    end

    assert_redirected_to show_url(ShowRating.last.show)
  end

  test "should destroy show_rating" do
    assert_difference('ShowRating.count', -1) do
      delete show_rating_url(@show_rating)
    end

    assert_redirected_to show_ratings_url
  end
  
  test "should not create invalid show_rating" do
    assert_difference('ShowRating.count', 0) do
      post show_ratings_url, params: { show_rating: { rating: 6, show_id: @show_rating.show_id } }
    end
  end
end
