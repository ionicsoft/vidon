class ProfileComment < ApplicationRecord
  belongs_to :customer
  belongs_to :customer, :foreign_key => 'commentor_id'
end
