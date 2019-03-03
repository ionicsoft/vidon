class Video < ApplicationRecord
  belongs_to :episode
  belongs_to :movie
  has_many :video_comments
  validates :title, presence: true
  validates :description, presence: true
end
