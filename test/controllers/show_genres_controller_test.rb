require 'test_helper'

class ShowGenresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @show_genre = show_genres(:one)
    @producer = @show_genre.show.producer.person
    log_in_as(@producer)
  end

  test "should create show_genre" do
    assert_difference('ShowGenre.count', 1) do
      post show_genres_url, params: { show_genre: { genre: "comedy", show_id: @show_genre.show_id } }, headers: { 'HTTP_REFERER' => @show_genre.show }
    end

    assert_redirected_to @show_genre.show
  end

  test "should destroy show_genre" do
    assert_difference('ShowGenre.count', -1) do
      delete show_genre_url(@show_genre), headers: { 'HTTP_REFERER' => @show_genre.show }
    end

    assert_redirected_to @show_genre.show
  end
  
  test "should render new if genre does not save" do
    assert_difference('ShowGenre.count', 0) do
      post show_genres_url, params: { show_genre: { genre: 'game', show_id: @show_genre.show_id + 1 } }, headers: { 'HTTP_REFERER' => @show_genre.show }
    end
  end
  
  test "should redirect if not correct producer" do
    temp = show_genres(:three)
    assert_difference('ShowGenre.count', 0) do
      delete show_genre_url(temp), headers: { 'HTTP_REFERER' => show_genres_url }
    end
  end
end
