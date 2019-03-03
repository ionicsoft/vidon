class ShowGenre < ApplicationRecord
  belongs_to :show
  validates :genre, presence: true
end
