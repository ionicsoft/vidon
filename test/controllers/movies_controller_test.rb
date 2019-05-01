require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
    @producer = @movie.producer.person
    @customer = customers(:one)
  end

  test "should get new" do
    log_in_as(@producer)
    get new_movie_url
    assert_response :success
  end

  test "should create movie" do
    log_in_as(@producer)
    assert_difference('Movie.count', 1) do
      post movies_url, params: { movie: { producer_id: @movie.producer_id } }
    end

    assert_redirected_to movie_url(Movie.last)
  end

  test "should show movie" do
    log_in_as(@customer.person)
    get movie_url(@movie)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@producer)
    get edit_movie_url(@movie)
    assert_response :success
  end

  test "should update movie" do
    log_in_as(@producer)
    patch movie_url(@movie), params: { movie: { producer_id: @movie.producer_id } }
    assert_redirected_to movie_url(@movie)
  end

  test "should destroy movie" do
    log_in_as(@producer)
    assert_difference('Movie.count', -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
end
