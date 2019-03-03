class MovieActor < ApplicationRecord
  belongs_to :movie
  validates :name, presence: true
end
