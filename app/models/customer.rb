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
  after_initialize :defaults_set
  
  accepts_nested_attributes_for :person, allow_destroy: true

  def defaults_set
    self.slots ||= 10
    self.renewal_date ||= 30.days.from_now
  end
  
  def self.search(search)  
   where("lower(people.username) LIKE :search", search: "%#{search.downcase}%").uniq
  end
  
  def can_friend?(customer)
    self != customer && !has_friend?(customer) and customer.friend_requests.find_by(requester_id: self.id).nil?
  end
  
  def has_friend?(friend)
    friends.include?(friend)
  end
  
  def remove_friend(friend)
    friends.destroy(friend)
  end
  def open_slots?
    subscriptions.count < slots
  end
  
  def has_subscription?(show)
    !(subscriptions.find_by show_id: show.id).nil?
  end
  
  def can_subscribe?(show)
    open_slots? && !has_subscription?(show)
  end
  
end
