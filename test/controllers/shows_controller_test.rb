require 'test_helper'

class ShowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show = shows(:one)
    @producer = @show.producer.person
    log_in_as(@producer)
  end

  test "should get new" do
    get new_show_url
    assert_response :success
  end

  test "should create show" do
    assert_difference('Show.count', 1) do
      post shows_url, params: { show: { name: "The Rod Show", producer_id: @show.producer_id, description: "Our favorite teacher" } }
    end

    assert_redirected_to show_url(Show.last)
  end

  test "should show show" do
    get show_url(@show)
    assert_response :success
  end

  test "should get edit" do
    get edit_show_url(@show)
    assert_response :success
  end

  test "should update show" do
    patch show_url(@show), params: { show: { name: @show.name, producer_id: @show.producer_id, description: @show.description } }
    assert_redirected_to show_url(@show)
  end

  test "should destroy show" do
    assert_difference('Show.count', -1) do
      delete show_url(@show)
    end

    assert_redirected_to pro_shows_url
  end
end
