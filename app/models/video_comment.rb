class VideoComment < ApplicationRecord
  belongs_to :video
  belongs_to :customer
  validates :comment, presence: true
end
