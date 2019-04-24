class Payment < ApplicationRecord
  belongs_to :customer
  has_many :invoices, dependent: :destroy
  validates :card_name, presence: true
  validates :card_num, presence: true, length: { is: 16 }, numericality: { greater_than: 0, only_integer: true, message: "is invalid" }
  validates :cvc, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 1000, only_integer: true, message: "is invalid" }
  validates :expiration, presence: true
  validate :expiration_date_cannot_be_in_the_past

  def expiration_date_cannot_be_in_the_past
    if expiration.present? && expiration < Date.today
      errors.add(:expiration, "can't be in the past")
    end
  end    
end
