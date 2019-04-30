require 'test_helper'

class ShowGenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show_genre = show_genres(:one)
    @producer = @show_genre.show.producer.person
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :firefox)
    end
    log_in_as(@producer)
  end

  test "should get index" do
    get show_genres_url
    assert_response :success
  end

  test "should get new" do
    get new_show_genre_url
    assert_response :success
  end

  test "should create show_genre" do
    #does not create show genre
    assert_difference('ShowGenre.count', 1) do
      post show_genres_url, params: { show_genre: { genre: "comedy", show_id: @show_genre.show_id } }
    end

    assert_redirected_to show_genre_url(ShowGenre.last)
  end

  test "should show show_genre" do
    get show_genre_url(@show_genre)
    #assert_response :redirect
    assert_response :success
  end

  test "should get edit" do
    get edit_show_genre_url(@show_genre)
    #assert_response :redirect
    assert_response :success
  end

  test "should update show_genre" do
    patch show_genre_url(@show_genre), params: { show_genre: { genre: @show_genre.genre, show_id: @show_genre.show_id } }
    #assert_redirected_to show_genre_url(@show_genre)
  end

  test "should destroy show_genre" do
    #does not destroy show genre
    assert_difference('ShowGenre.count', -1) do
      delete show_genre_url(@show_genre)
    end

    assert_redirected_to show_genres_url
  end
end
