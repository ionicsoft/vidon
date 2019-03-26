class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :profile_comments
  has_many :video_comments
  has_many :movie_ratings
  has_many :show_ratings
  has_many :friends
  has_many :friend_requests
  has_one :payment
  has_one :person, :as => :user, :inverse_of => :user
  validates :slots, numericality: { greater_than_or_equal_to: 5 }
  after_initialize :default_slots
  
  accepts_nested_attributes_for :person, allow_destroy: true

  def default_slots
    self.slots ||= 5
  end
  
  def self.search(search)  
   where("lower(people.username) LIKE :search", search: "%#{search.downcase}%").uniq   
  end
end
