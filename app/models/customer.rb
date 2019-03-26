class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :profile_comments
  has_many :video_comments
  has_many :movie_ratings
  has_many :show_ratings
  has_one :payment
  has_one :person, :as => :user, :inverse_of => :user
  validates :slots, numericality: { greater_than_or_equal_to: 5 }
  after_initialize :defaults_set
  
  accepts_nested_attributes_for :person, allow_destroy: true

  def defaults_set
    self.slots ||= 10
    self.renewal_date ||= 30.days.from_now
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
  
  #called once a day from schedule.rb
  def subscription_renewal
    if self.renewal_date = Date.today
      self.renewal_date ||= 30.days.from_now
      #call renewal procedures
  end
end
