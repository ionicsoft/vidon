class Producer < ApplicationRecord
  has_one :person, :as => :user
  has_many :shows
  has_many :movies
  validates :company_name, presence: true
  
  accepts_nested_attributes_for :person, allow_destroy: true
end
