require 'test_helper'

class ShowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show = shows(:one)
    @producer = @show.producer.person
  end

  test "should get index" do
    get shows_url
    assert_response :success
  end

  test "should get new" do
    log_in_as @producer
    get new_show_url
    assert_response :success
  end

  test "should create show" do
    log_in_as @producer
    assert_difference('Show.count') do
      post shows_url, params: { show: { name: @show.name, producer_id: @show.producer_id, description: @show.description } }
    end

    assert_redirected_to show_url(Show.last)
  end

  # test "should show show" do
  #   log_in_as @producer
  #   get show_url(@show)
  #   assert_response :success
  # end

  test "should get edit" do
    log_in_as @producer
    get edit_show_url(@show)
    assert_response :success
  end

  test "should update show" do
    log_in_as @producer
    patch show_url(@show), params: { show: { name: @show.name, producer_id: @show.producer_id, description: @show.description } }
    assert_redirected_to show_url(@show)
  end

  test "should destroy show" do
    log_in_as @producer
    assert_difference('Show.count', -1) do
      delete show_url(@show)
    end

    assert_redirected_to pro_shows_path
  end
end
