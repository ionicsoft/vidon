class FriendRequest < ApplicationRecord
    belongs_to :customer
    belongs_to :requester, class_name: "Customer", foreign_key: 'requester_id'
    
    def accept
        customer.friends << requester
        destroy
    end
end
