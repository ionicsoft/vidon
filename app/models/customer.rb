class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :profile_comments
  has_many :video_comments
  has_many :movie_ratings
  has_many :show_ratings
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :friend_requests, dependent: :destroy
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
  
  def can_friend?(customer)
    self != customer && !has_friend?(customer) and friend_requests.find_by(customer_id: customer.id).nil?
  end
  
  def has_friend?(friend)
    friends.include?(friend)
  end
  
  def remove_friend(friend)
    friends.destroy(friend)
  end
end
