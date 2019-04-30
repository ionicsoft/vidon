require 'test_helper'

class MovieGenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_genre = movie_genres(:one)
    @movie = movies(:one)
    @producer = @movie_genre.movie.producer.person
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@producer)
  end

  test "should get index" do
    get movie_genres_url
    assert_response :success
  end

  test "should get new" do
    get new_movie_genre_url
    assert_response :success
  end

  test "should create movie_genre" do
    #does not create movie genre
    assert_difference('MovieGenre.count', 1) do
      post movie_genres_url, params: { movie_genre: { genre: "comedy", movie_id: @movie.id } }
    end

    assert_redirected_to movie_genre_url(MovieGenre.last)
  end

  test "should show movie_genre" do
    get movie_genre_url(@movie_genre)
    #assert_response :redirect
    assert_response :success
  end

  test "should get edit" do
    get edit_movie_genre_url(@movie_genre)
    #assert_response :redirect
    assert_response :success
  end

  test "should update movie_genre" do
    patch movie_genre_url(@movie_genre), params: { movie_genre: { genre: @movie_genre.genre, movie_id: @movie_genre.movie_id } }
    #assert_redirected_to movie_genre_url(@movie_genre)
  end

  test "should destroy movie_genre" do
    #does not destroy movie genre
    assert_difference('MovieGenre.count', -1) do
      delete movie_genre_url(@movie_genre)
    end

    assert_redirected_to movie_genres_url
  end
end
