class FriendRequestsController < ApplicationController
  def new
    @req = FriendRequest.new
  end
  
  def index
    @requests = FriendRequest.all
  end
  
  def create
    @req = FriendRequest.new(params[:friend_requests])
    respond_to do |format|
      if @req.save
        format.html { redirect_to '/', notice: 'Request successfully sent' }
        format.json { render :show, status: :created, location: @req }
      else
        format.html { render :new }
        format.json { render json: @req.errors, status: :unprocessable_entity }
      end
    end
  end 
  
  def show
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @req.update(params[:friends])
        format.html { redirect_back(fallback_location: root_url) }
        format.json { render :show, status: :ok, location: @req }
      else
        format.html { render :edit }
        format.json { render json: @req.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @req.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def delete_req
    @decline = FriendRequest.find_by(params[:friend_requests])
    @decline.destroy
  end
  
  def add_friend
    Friend.create(params[:friend_requests])
    @temp = FriendRequest.find_by(params[:friend_requests])
    @temp.destroy
  end
  
  def delete_friend
    @unfriend = Friend.find_by(params[:friends])
    @unfriend.destroy
  end
  
end