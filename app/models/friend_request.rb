class FriendRequest < ApplicationRecord
    belongs_to :customer
    belongs_to :requester, class_name: "Customer", foreign_key: 'requester_id'
    validates :customer_id, presence: true
    validates :requester_id, presence: true
    # Cannot FR oneself
    validates :customer_id, exclusion: { in: ->(fr) { [fr.requester_id] } }
    
    def accept
        customer.friends << requester
        destroy
    end
end
