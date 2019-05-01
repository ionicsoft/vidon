require 'test_helper'

class MovieGenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_genre = movie_genres(:one)
    @movie = movies(:one)
    @producer = @movie_genre.movie.producer.person
    log_in_as(@producer)
  end

  test "should create movie_genre" do
    assert_difference('MovieGenre.count', 1) do
      post movie_genres_url, params: { movie_genre: { genre: "comedy", movie_id: @movie.id } }, headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to @movie
  end

  test "should update movie_genre" do
    patch movie_genre_url(@movie_genre), params: { movie_genre: { genre: @movie_genre.genre, movie_id: @movie_genre.movie_id } }
    assert_redirected_to movie_url(@movie_genre.movie)
  end

  test "should destroy movie_genre" do
    assert_difference('MovieGenre.count', -1) do
      delete movie_genre_url(@movie_genre), headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to @movie
  end
end
