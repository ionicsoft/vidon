class MovieGenre < ApplicationRecord
  belongs_to :movie
  validates :genre, presence: true
end
