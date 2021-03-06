class ProfileComment < ApplicationRecord
  belongs_to :customer
  belongs_to :commentor, class_name: "Customer", :foreign_key => 'commentor_id'
  validates :comment, presence: true
end
