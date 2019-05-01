require 'test_helper'

class MovieActorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @movie_actor = movie_actors(:one)
    @movie = movies(:one)
    @producer = @movie_actor.movie.producer.person
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@producer)
  end

  test "should create movie_actor" do
    #does not create movie actor
    assert_difference('MovieActor.count', 1) do
      post movie_actors_url, params: { movie_actor: { movie_id: @movie.id, name: "Leo Di Caprio" } }, headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to @movie
  end

  test "should update movie_actor" do
    patch movie_actor_url(@movie_actor), params: { movie_actor: { movie_id: @movie_actor.movie_id, name: @movie_actor.name } }
    #assert_redirected_to movie_actor_url(@movie_actor)
  end

  test "should destroy movie_actor" do
    #does not destroy movie actor
    assert_difference('MovieActor.count', -1) do
      delete movie_actor_url(@movie_actor), headers: { 'HTTP_REFERER' => @movie }
    end

    assert_redirected_to @movie
  end
end
