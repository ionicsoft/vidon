require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  setup do
    @show = shows(:one)
    @video = @show.episodes.find_by(absolute_episode: 1).video
  end
  
  test "return next episode in series" do
    assert_equal @video.next_video, @show.episodes.find_by(absolute_episode: 2).video
  end
  
  test "return nil for nect_video if video is movie" do
    assert_nil videos(:six).next_video
  end
end
