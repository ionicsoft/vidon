class Invoice < ApplicationRecord
    validates :payment_id, presence: true
    validates :amount, presence: true
    validates :description, presence: true
end
