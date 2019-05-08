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

  test "should create show_genre" do
    #does not create show genre
    assert_difference('ShowGenre.count', 1) do
      post show_genres_url, params: { show_genre: { genre: "comedy", show_id: @show_genre.show_id } }, headers: { 'HTTP_REFERER' => @show_genre.show }
    end

    assert_redirected_to @show_genre.show
  end

  test "should update show_genre" do
    patch show_genre_url(@show_genre), params: { show_genre: { genre: @show_genre.genre, show_id: @show_genre.show_id } }
    #assert_redirected_to show_genre_url(@show_genre)
  end

  test "should destroy show_genre" do
    #does not destroy show genre
    assert_difference('ShowGenre.count', -1) do
      delete show_genre_url(@show_genre), headers: { 'HTTP_REFERER' => @show_genre.show }
    end

    assert_redirected_to @show_genre.show
  end
end
