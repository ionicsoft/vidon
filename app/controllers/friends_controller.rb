class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy
  # Authorization
  before_action :logged_in_customer
  
  def destroy
    current_person.user.remove_friend(@friend)
    head :no_content
  end
  
  private
    def set_friend
      @friend = current_person.user.friends.find(params[:id])
    end
end
