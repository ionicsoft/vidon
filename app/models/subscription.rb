class Subscription < ApplicationRecord
  belongs_to :customer
  has_one :show
end
