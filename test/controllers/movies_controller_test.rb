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
      post movies_url, params: { movie: {
        producer_id: @movie.producer_id,
        video_attributes: {
          title: "Foo",
          description: "Foo bar"
        } } }
    end

    assert_redirected_to movie_url(Movie.last)
  end
  
  test "should not create movie with invalid data" do
    log_in_as(@producer)
    assert_difference('Movie.count', 0) do
      post movies_url, params: { movie: { producer_id: "" } }
    end

    assert_template 'movies/new'
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
  
  test "should not get edit for other producer's movie" do
    log_in_as(producers(:two).person)
    get edit_movie_url(@movie)
    assert_redirected_to root_url
  end

  test "should update movie" do
    log_in_as(@producer)
    patch movie_url(@movie), params: { movie: { producer_id: @movie.producer_id } }
    assert_redirected_to movie_url(@movie)
  end
  
  test "should not update movie with invalid data" do
    log_in_as(@producer)
    patch movie_url(@movie), params: { movie: { 
      producer_id: "",
      video_attributes: {
        title: "",
        description: ""
    } } }
    assert_template 'movies/edit'
  end

  test "should destroy movie" do
    log_in_as(@producer)
    assert_difference('Movie.count', -1) do
      delete movie_url(@movie)
    end

    assert_redirected_to movies_url
  end
  
  test "should not allow customer write access" do
    log_in_as(customers(:one).person)
    get edit_movie_url(@movie)
    assert_redirected_to root_url
    assert_equal "Content not available for customers.", flash[:danger]
  end
end
