require 'test_helper'

class ShowActorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show_actor = show_actors(:one)
    @producer = @show_actor.show.producer.person
    log_in_as(@producer)
  end

  test "should create show_actor" do
    assert_difference('ShowActor.count', 1) do
      post show_actors_url, params: { show_actor: { name: "Leo DiCaprio", show_id: @show_actor.show_id } }, headers: { 'HTTP_REFERER' => @show_actor.show }
    end

    assert_redirected_to @show_actor.show
  end

  test "should destroy show_actor" do
    assert_difference('ShowActor.count', -1) do
      delete show_actor_url(@show_actor), headers: { 'HTTP_REFERER' => show_actors_url }
    end

    assert_redirected_to show_actors_url
  end
  
  test "should render new if actor does not save" do
    assert_difference('ShowActor.count', 0) do
      post show_actors_url, params: { show_actor: { name: "Leo DiCaprio", show_id: @show_actor.show_id + 1 } }, headers: { 'HTTP_REFERER' => @show_actor.show }
    end
  end
  
  test "should redirect if not correct producer" do
    temp = show_actors(:two)
    assert_difference('ShowActor.count', 0) do
      delete show_actor_url(temp), headers: { 'HTTP_REFERER' => show_actors_url }
    end
  end
end
