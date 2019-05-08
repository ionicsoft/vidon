class Customer < ApplicationRecord
  has_many :subscriptions, dependent: :destroy
  has_many :profile_comments, dependent: :destroy
  has_many :video_comments, dependent: :destroy
  has_many :movie_ratings, dependent: :destroy
  has_many :show_ratings, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :friend_requests, dependent: :destroy
  has_many :rentals, dependent: :destroy
  has_one :payment, dependent: :destroy
  has_one :person, :as => :user, :inverse_of => :user, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :watch_histories, dependent: :destroy
  
  validates :slots, numericality: { greater_than_or_equal_to: 5 }
  after_initialize :defaults_set
  
  accepts_nested_attributes_for :person, update_only: true
  accepts_nested_attributes_for :payment, update_only: true

  # Set default attributes for a customer when created
  def defaults_set
    self.slots ||= 10
    self.renewal_date ||= 30.days.from_now
  end
  
  # Looks for customers based on their username
  def self.search(search)  
   where("lower(people.username) LIKE :search", search: "%#{search.downcase}%").uniq
  end
  
  # Returns true if the customer can be added to the customer's friend list
  def can_friend?(customer)
    self != customer && !has_friend?(customer) and customer.friend_requests.find_by(requester_id: self.id).nil?
  end
  
  # Returns true if the friend is already in the customers friend list
  def has_friend?(friend)
    friends.include?(friend)
  end
  
  # Removes the specified friend (Customer) from their friends list
  def remove_friend(friend)
    friends.destroy(friend)
  end
  
  # Returns true if the customer has open slots for subscription
  def open_slots?
    subscriptions.size < slots
  end
  
  # Returns number of available slow slots.
  def open_slots
    slots - subscriptions.size
  end
  
  # Returns true if the customer is already subscribed to the show
  def has_subscription?(show)
    !(subscriptions.find_by show_id: show.id).nil?
  end
  
  # Sends activation email.
  def send_notice_email
    PersonMailer.sub_notice(self.person).deliver_now
  end
  
end
