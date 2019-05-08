require 'test_helper'

class ShowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show = shows(:one)
    @producer = @show.producer.person
  end

  test "should get new" do
    log_in_as(@producer)
    get new_show_url
    assert_response :success
  end

  test "should create show" do
    log_in_as(@producer)
    assert_difference('Show.count', 1) do
      post shows_url, params: { show: { name: "The Rod Show", producer_id: @show.producer_id, description: "Our favorite teacher" } }
    end

    assert_redirected_to show_url(Show.last)
  end
  
  test "should not create invalid show" do
    log_in_as(@producer)
    assert_difference('Show.count', 0) do
      post shows_url, params: { show: { name: "The Rod Show", producer_id: @show.producer_id + 1, description: "Our favorite teacher" } }
    end
  end

  test "should show show" do
    log_in_as(@producer)
    get show_url(@show)
    assert_response :success
  end
  
  test "should show show for customer" do
    temp = customers(:one)
    temp2 = temp.watch_histories.first
    temp2.update_attribute(:completed, true)
    temp2.update_attribute(:video_id, 5)
    log_in_as(temp.person)
    get show_url(@show)
  end

  test "should get edit" do
    log_in_as(@producer)
    get edit_show_url(@show)
    assert_response :success
  end
  
  test "should not edit if incorrect producer" do
    temp = shows(:two)
    log_in_as(@producer)
    get edit_show_url(temp)
    assert_redirected_to root_url
  end

  test "should update show" do
    log_in_as(@producer)
    patch show_url(@show), params: { show: { name: @show.name, producer_id: @show.producer_id, description: @show.description } }
    assert_redirected_to show_url(@show)
  end
  
  test "should not update invalid show" do
    log_in_as(@producer)
    patch show_url(@show), params: { show: { name: @show.name, producer_id: @show.producer_id + 1, description: @show.description } }
  end

  test "should destroy show" do
    log_in_as(@producer)
    assert_difference('Show.count', -1) do
      delete show_url(@show)
    end

    assert_redirected_to pro_shows_url
  end
end
