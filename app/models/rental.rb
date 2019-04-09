class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :movie
  validates :customer, presence: true
  validates :movie, presence: true, uniqueness: { scope: :customer }
  validates :expiration, presence: true
  
  after_initialize :defaults_set
  
  def defaults_set
    # Default expiration date is in 24 hours
    self.expiration ||= Time.current + 24.hours
  end
end
