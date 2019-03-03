class MovieRating < ApplicationRecord
  belongs_to :movie
  belongs_to :customer
  validates :rating, presence: true, inclusion: 1..5
end
