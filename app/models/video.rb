class Video < ApplicationRecord
  belongs_to :episode
  belongs_to :movie
  has_many :video_comments
end
