require 'test_helper'

class MovieActorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_actor = movie_actors(:one)
    @movie = movies(:one)
    @producer = @movie_actor.movie.producer.person
    log_in_as(@producer)
  end

  test "should create movie_actor" do
    assert_difference('MovieActor.count', 1) do
      post movie_actors_url, params: { movie_actor: { movie_id: @movie.id, name: "Leo Di Caprio" } }, headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to @movie
  end
  
  test "should not create movie actor without name" do
    assert_difference('MovieActor.count', 0) do
      post movie_actors_url, params: { movie_actor: { movie_id: @movie.id, name: "" } }, headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to @movie
  end

  test "should destroy movie_actor" do
    assert_difference('MovieActor.count', -1) do
      delete movie_actor_url(@movie_actor), headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to @movie
  end
  
  test "should not destroy other producer's movie actor" do
    assert_difference('MovieActor.count', 0) do
      delete movie_actor_url(movie_actors(:two)), headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to root_url
  end
end
