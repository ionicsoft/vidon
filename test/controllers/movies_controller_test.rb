require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie = movies(:one)
    @producer = @movie.producer.person
    @customer = customers(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  test "should get index" do
    log_in_as(@customer.person)
    get movies_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@producer)
    get new_movie_url
    assert_response :success
  end

  test "should create movie" do
    #does not create movie
    log_in_as(@producer)
    assert_difference('Movie.count', 1) do
      post movies_url, params: { movie: { producer_id: @movie.producer_id } }
    end

    assert_redirected_to movie_url(Movie.last)
  end

  test "should show movie" do
    log_in_as(@customer.person)
    get movie_url(@movie)
    #assert_response :redirect
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@producer)
    get edit_movie_url(@movie)
    #assert_response :redirect
    assert_response :success
  end

  test "should update movie" do
    log_in_as(@producer)
    patch movie_url(@movie), params: { movie: { producer_id: @movie.producer_id } }
    #assert_redirected_to movie_url(@movie)
  end

  test "should destroy movie" do
    #does not destroy movie
    log_in_as(@producer)
    assert_difference('Movie.count', -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
end
