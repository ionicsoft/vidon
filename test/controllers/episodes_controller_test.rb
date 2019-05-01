require 'test_helper'

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @episode = episodes(:one)
    @show = shows(:one)
    @producer = producers(:one)
    log_in_as(@producer.person)
  end

  #Begin coverage testing
  test "should get new" do
    get new_episode_url(@show)
    assert_response :success
  end

  test "should create episode" do
    assert_difference('Episode.count', 1) do
      post episodes_url, params: { episode: { absolute_episode: 1, episode: 1, season: 1, show_id: @show.id } }
    end

    assert_redirected_to show_url(Episode.last.show)
  end

  test "should get edit" do
    get edit_episode_url(@episode)
    assert_response :success
  end

  test "should update episode" do
    patch episode_url(@episode), params: { episode: { absolute_episode: @episode.absolute_episode, episode: @episode.episode, season: @episode.season, show_id: @episode.show_id } }
    assert_redirected_to show_url(@episode.show)
  end

  test "should destroy episode" do
    assert_difference('Episode.count', -1) do
      delete episode_url(@episode)
    end

    assert_redirected_to episodes_url
  end
end
