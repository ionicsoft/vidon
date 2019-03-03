class Payment < ApplicationRecord
  belongs_to :customer
  validates :card_name, presence: true
  validates :card_num, presence: true, length: { is: 16 }
  validates :cvc, presence: true, numericality: { less_than: 1000 }
  validates :expiration, presence: true
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if expiration.present? && expiration < Date.today
      errors.add(:expiration, "can't be in the past")
    end
  end    
end
