class MovieGenre < ApplicationRecord
  belongs_to :movie
  validates :genre, presence: true
  
  # Returns true if producer has edit permission
  def valid_producer?(producer)
    movie.valid_producer?(producer)
  end
end
