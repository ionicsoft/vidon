class Friendship < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :customer
  belongs_to :friend, class_name: 'Customer'
  
  validates :customer, presence: true
  validates :friend, presence: true, uniqueness: { scope: :customer }

  private
    def create_inverse_relationship
      friend.friendships.create(friend: customer)
    end
  
    def destroy_inverse_relationship
      friendship = friend.friendships.find_by(friend: customer)
      friendship.destroy if friendship
    end
end
