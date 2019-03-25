class FriendRequestsController < ApplicationController
    def friend_requests
    @requests = FriendRequest.all
    end
  
  def add_friend(customer)
    @userID = current_person
    Friend.create(customer_id: current_person.person.id, friend_id: customer.person.id)
  end
  
  def create_request(customer)
    FriendRequest.create(customer_id: customer.id, requester_id: current_person)
  end 
  
  def delete_request(frendrequest)
     @req = FriendRequest.find_by(frendrequest)
     @req.destroy
  end
end