class Video < ApplicationRecord
  belongs_to :content, polymorphic: true
  has_many :video_comments, dependent: :destroy
  has_one_attached :clip
  has_one_attached :thumbnail

  validates :title, presence: true
  validates :description, presence: true
  
  def episode?
    content_type == "Episode"
  end

  def movie?
    content_type == "Movie"
  end
  
  # Returns true if producer has edit permission
  def valid_producer?(producer)
    content.valid_producer?(producer)
  end
end
