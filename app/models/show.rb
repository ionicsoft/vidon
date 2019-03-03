class Show < ApplicationRecord
  belongs_to :producer
  has_many :show_genres
  has_many :show_actors
  has_many :show_ratings
  has_many :episodes
  belongs_to :subscription
  validates :name, presence: true
  validates :description, presence: true
end
