class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :profile_comments
  has_many :video_comments
  has_many :movie_ratings
  has_many :show_ratings
  has_one :payment
  has_one :person, :as => :user
  validates :slots, numericality: { greater_than_or_equal_to: 5 }
  after_initialize :default_slots

  def default_slots
    self.slots ||= 5
  end
end
