class Movie < ApplicationRecord
  belongs_to :producer
  has_one :video, :as => :content
  has_many :movie_actors
  has_many :movie_genres
  has_many :movie_ratings
  
  def self.search(search)  
   where("lower(videos.title) LIKE :search", search: "%#{search.downcase}%").uniq   
  end
end
