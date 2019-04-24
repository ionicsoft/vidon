class Movie < ApplicationRecord
  belongs_to :producer
  has_one :video, as: :content, dependent: :nullify
  has_many :movie_actors
  has_many :movie_genres
  has_many :movie_ratings
  has_many :rentals, dependent: :destroy
  has_many :favorites, as: :content, dependent: :destroy
  has_one_attached :promo_image
  ratyrate_rateable 'rating'
  
  accepts_nested_attributes_for :video, allow_destroy: true
  
  def self.search(search)  
   where("lower(videos.title) LIKE :search", search: "%#{search.downcase}%").uniq   
  end
  
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
