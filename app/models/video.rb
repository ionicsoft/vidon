class Video < ApplicationRecord
  belongs_to :content, polymorphic: true
  has_many :video_comments
  has_one_attached :clip
  has_one_attached :thumbnail

  validates :title, presence: true
  validates :description, presence: true
end
