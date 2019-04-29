class Movie < ApplicationRecord
  belongs_to :producer
  has_one :video, as: :content, dependent: :nullify
  has_many :movie_actors
  has_many :movie_genres
  has_many :movie_ratings
  has_many :rentals, dependent: :destroy
  has_many :favorites, as: :content, dependent: :destroy
  has_one_attached :promo_image
  
  accepts_nested_attributes_for :video, update_only: true
  
  def title
    video.title
  end
  
  def description
    video.description
  end
  
  def valid_producer?(producer)
    producer == self.producer
  end
end
