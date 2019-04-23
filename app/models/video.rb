class Video < ApplicationRecord
  belongs_to :content, polymorphic: true
  has_many :video_comments, dependent: :destroy
  has_one_attached :clip
  has_one_attached :thumbnail

  validates :title, presence: true
  validates :description, presence: true
  
  # Returns true if video content is an episode
  def episode?
    content_type == "Episode"
  end

  # Returns true if video content is a movie
  def movie?
    content_type == "Movie"
  end
  
  # Returns the next video in a playlist
  def next_video
    if episode?
      episode = content.next_ep
      unless episode.nil?
        episode.video
      end
    end
  end
  
  # Returns the next episode or the show if not found
  def next_video_or_show
    ep = next_video
    if ep.nil?
      content.show
    end
  end
  
  # Returns the previous video in a playlist
  def prev_video
    if episode?
      episode = content.prev_ep
      unless episode.nil?
        episode.video
      end
    end
  end
  
  # Returns true if producer has edit permission
  def valid_producer?(producer)
    content.valid_producer?(producer)
  end
end
