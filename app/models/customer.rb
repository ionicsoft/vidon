class Customer < ApplicationRecord
  has_one :payment
  has_many :subscriptions
  has_many :profile_comments
  has_one :person, :as => :user
end
