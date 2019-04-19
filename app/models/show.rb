class Show < ApplicationRecord
  belongs_to :producer
  has_many :show_genres
  has_many :show_actors
  has_many :show_ratings
  has_many :episodes
  has_many :subscriptions
  validates :name, presence: true
  validates :description, presence: true
  has_one_attached :promo_image
  
  # Returns true if producer has edit permission
  def valid_producer?(producer)
    producer == self.producer
  end
end
