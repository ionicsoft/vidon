class FriendRequest < ApplicationRecord
    belongs_to :customer
    belongs_to :customer, :foreign_key => 'requester_id'
end