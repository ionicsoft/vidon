class Producer < ApplicationRecord
  has_one :person, :as => :user
  has_many :shows
  has_many :movies
end
