require 'test_helper'

class ShowActorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show_actor = show_actors(:one)
    @producer = @show_actor.show.producer.person
  end

  test "should get index" do
    log_in_as @producer
    get show_actors_url
    assert_response :success
  end

  test "should get new" do
    log_in_as @producer
    get new_show_actor_url
    assert_response :success
  end

  test "should create show_actor" do
    log_in_as @producer
    assert_difference('ShowActor.count') do
      post show_actors_url, params: { show_actor: { name: @show_actor.name, show_id: @show_actor.show_id } }
    end

    assert_redirected_to show_actor_url(ShowActor.last)
  end

  test "should show show_actor" do
    log_in_as @producer
    get show_actor_url(@show_actor)
    assert_response :success
  end

  test "should get edit" do
    log_in_as @producer
    get edit_show_actor_url(@show_actor)
    assert_response :success
  end

  test "should update show_actor" do
    log_in_as @producer
    patch show_actor_url(@show_actor), params: { show_actor: { name: @show_actor.name, show_id: @show_actor.show_id } }
    assert_redirected_to show_actor_url(@show_actor)
  end

  test "should destroy show_actor" do
    log_in_as @producer
    assert_difference('ShowActor.count', -1) do
      delete show_actor_url(@show_actor)
    end

    assert_redirected_to show_actors_url
  end
end
