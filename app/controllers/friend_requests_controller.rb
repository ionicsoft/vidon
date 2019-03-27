class FriendRequestsController < ApplicationController
  before_action :set_request, only: [:destroy, :update]
  
  def create
    @request = FriendRequest.new(request_params)
    respond_to do |format|
      if @request.save
        format.html { redirect_to @request.customer, notice: 'Request successfully sent' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render html: "nooo" }
        format.json { render json: @request.errors, status: :unprocessable_entity }
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
    def set_request
      @request = FriendRequest.find(params[:id])
    end
    
    def request_params
      params.require(:friend_request).permit(:customer_id, :requester_id)
    end
end
