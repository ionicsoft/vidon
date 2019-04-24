class FavoritesController < ApplicationController
  # Authorization
  before_action :logged_in_customer
  before_action :correct_customer, only: [:destroy]
  
  # Create new favorite for current customer
  def create
    fav_params = params.require(:favorite).permit(:content_id, :content_type)
    @favorite = Favorite.new(fav_params)
    @favorite.customer_id = current_person.user.id
    @favorite.save
    redirect_to request.referer
  end
  
  # Delete favorite
  def destroy
    @favorite.destroy
    redirect_to request.referer
  end
  
  private
    
    # Check favorite belongs to current user
    def correct_customer
      @favorite = Favorite.find(params[:id])
      current_person.user == @favorite.customer
    end
end
