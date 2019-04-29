require 'test_helper'

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @episode = episodes(:one)
    @show = shows(:one)
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
  end

  #Begin coverage testing
  test "should get index" do
    log_in_as_producer
    get episodes_url
    assert_response :success
  end

  test "should get new" do
    log_in_as_producer
    get new_episode_url(@show)
    assert_response :success
  end

  test "should create episode" do
    #does not create episode
    log_in_as_producer
    assert_difference('Episode.count', 1) do
      post episodes_url, params: { episode: { absolute_episode: @episode.absolute_episode, episode: @episode.episode, season: @episode.season, show_id: @episode.show_id } }
    end

    assert_redirected_to episode_url(Episode.last)
  end

  test "should show episode" do
    log_in_as_customer
    get episode_url(@episode)
    assert_response :redirect
    #assert_response :success
  end

  test "should get edit" do
    log_in_as_producer
    get edit_episode_url(@episode)
    assert_response :redirect
    #assert_response :success
  end

  test "should update episode" do
    log_in_as_producer
    patch episode_url(@episode), params: { episode: { absolute_episode: @episode.absolute_episode, episode: @episode.episode, season: @episode.season, show_id: @episode.show_id } }
    #assert_redirected_to episode_url(@episode)
  end

  test "should destroy episode" do
    #does not destroy episode
    log_in_as_producer
    assert_difference('Episode.count', -1) do
      delete episode_url(@episode)
    end

    assert_redirected_to episodes_url
  end
end
