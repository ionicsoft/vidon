class Invoice < ApplicationRecord
    belongs_to :payment
    validates :payment_id, presence: true
    validates :amount, presence: true
    validates :description, presence: true
end
