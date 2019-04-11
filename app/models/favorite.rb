class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :content, polymorphic: true
  
  validates :customer, presence: true, uniqueness: { scope: :content }
end
