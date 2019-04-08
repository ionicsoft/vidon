class Movie < ApplicationRecord
  belongs_to :producer
  has_one :video, :as => :content, dependent: :nullify
  has_many :movie_actors, dependent: :destroy
  has_many :movie_genres, dependent: :destroy
  has_many :movie_ratings, dependent: :destroy
  has_many :rentals, dependent: :destroy
  
  def self.search(search)  
   where("lower(videos.title) LIKE :search", search: "%#{search.downcase}%").uniq   
  end
  
  def title
    video.title
  end
  
  def description
    video.description
  end
end
