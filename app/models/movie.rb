class Movie < ApplicationRecord
  belongs_to :producer
  has_one :video
  has_many :movie_actors
  has_many :movie_genres
  has_many :movie_ratings
end
