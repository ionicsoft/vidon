require 'test_helper'

class MovieActorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_actor = movie_actors(:one)
    @person = Customer.first.person
    @producer = @movie_actor.movie.producer.person
  end

  test "should get index" do
    log_in_as(@person)
    get movie_actors_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@producer)
    get new_movie_actor_url
    assert_response :success
  end

  test "should create movie_actor" do
    log_in_as(@producer)
    assert_difference('MovieActor.count') do
      post movie_actors_url, params: { movie_actor: { movie_id: @movie_actor.movie_id, name: @movie_actor.name } }
    end

    assert_redirected_to movie_actor_url(MovieActor.last)
  end

  test "should show movie_actor" do
    log_in_as(@person)
    get movie_actor_url(@movie_actor)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@producer)
    get edit_movie_actor_url(@movie_actor)
    assert_response :success
  end

  test "should update movie_actor" do
    log_in_as(@producer)
    patch movie_actor_url(@movie_actor), params: { movie_actor: { movie_id: @movie_actor.movie_id, name: @movie_actor.name } }
    assert_redirected_to movie_actor_url(@movie_actor)
  end

  test "should destroy movie_actor" do
    log_in_as(@producer)
    assert_difference('MovieActor.count', -1) do
      delete movie_actor_url(@movie_actor)
    end

    assert_redirected_to movie_actors_url
  end
end
