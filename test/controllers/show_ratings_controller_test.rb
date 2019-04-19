require 'test_helper'

class ShowRatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show_rating = show_ratings(:one)
    @customer = Customer.first.person
  end

  test "should get index" do
    log_in_as(@customer)
    get show_ratings_url
    assert_response :success
  end

  test "should get new" do
    log_in_as(@customer)
    get new_show_rating_url
    assert_response :success
  end

  test "should create show_rating" do
    log_in_as(@customer)
    assert_difference('ShowRating.count') do
      post show_ratings_url, params: { show_rating: { rating: @show_rating.rating, show_id: @show_rating.show_id } }
    end

    assert_redirected_to show_rating_url(ShowRating.last)
  end

  test "should show show_rating" do
    log_in_as(@customer)
    get show_rating_url(@show_rating)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@customer)
    get edit_show_rating_url(@show_rating)
    assert_response :success
  end

  test "should update show_rating" do
    log_in_as(@customer)
    patch show_rating_url(@show_rating), params: { show_rating: { rating: @show_rating.rating, show_id: @show_rating.show_id } }
    assert_redirected_to show_rating_url(@show_rating)
  end

  test "should destroy show_rating" do
    log_in_as(@customer)
    assert_difference('ShowRating.count', -1) do
      delete show_rating_url(@show_rating)
    end

    assert_redirected_to show_ratings_url
  end
end
