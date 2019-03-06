class Video < ApplicationRecord
  belongs_to :content, polymorphic: true
  has_many :video_comments
  validates :title, presence: true
  validates :description, presence: true
end