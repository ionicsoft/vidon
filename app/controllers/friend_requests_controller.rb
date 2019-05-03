class FriendRequestsController < ApplicationController
  before_action :set_request, only: [:destroy, :update]
  # Authorization
  before_action :logged_in_customer
  before_action :correct_customer, only: [:update, :destroy]
  
  def create
    @request = FriendRequest.new(request_params)
    # Look to see if a request already exists for sender
    existing = FriendRequest.find_by(requester: @request.customer, customer: @request.requester)
    if existing
      # Accept pending request instead of making another one
      existing.accept
      redirect_to @request.customer, notice: "Friend added"
    else
      # Send new friend request
      if @request.save
        redirect_to @request.customer, notice: 'Request successfully sent'
      else
        render html: "nooo"
      end
    end
  end 
  
  def update
    @request.accept
    redirect_to friends_path
  end
  
  def destroy
    @request.destroy
    redirect_to friends_path
  end
  
  private
    # Load friend request from database
    def set_request
      @request = FriendRequest.find(params[:id])
    end
    
    # Verify friend request belongs to current customer
    def correct_customer
      @request.requester == current_person.user or @request.customer == current_person.user
    end
    
    # Don't trust parameters from the internet
    def request_params
      params.require(:friend_request).permit(:customer_id, :requester_id)
    end
end
