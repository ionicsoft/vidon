require 'test_helper'

class MovieRatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_rating = movie_ratings(:one)
    @customer = customers(:one)
    log_in_as(@customer.person)
  end

  test "should create movie_rating" do
    temp = Customer.create
    assert_difference('MovieRating.count', 1) do
      post movie_ratings_url, params: { movie_rating: { movie_id: @movie_rating.movie_id, rating: 3, customer_id: temp.id } }
      post movie_ratings_url, params: { movie_rating: { movie_id: @movie_rating.movie_id, rating: 5, customer_id: temp.id } }
    end

    assert_redirected_to movie_url(MovieRating.last.movie)
  end
  
  test "should not create invalid movie_rating" do
    temp = Customer.create
    assert_difference('MovieRating.count', 0) do
      post movie_ratings_url, params: { movie_rating: { movie_id: @movie_rating.movie_id, rating: 30, customer_id: temp.id } }
    end

    assert_redirected_to movie_url(MovieRating.last.movie)
  end

  test "should destroy movie_rating" do
    assert_difference('MovieRating.count', -1) do
      delete movie_rating_url(@movie_rating)
    end

    assert_redirected_to movie_ratings_url
  end
end
