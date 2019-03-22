class Friend < ApplicationRecord
    belongs_to :customer
    belongs_to :customer, :foreign_key => 'friend_id'
end