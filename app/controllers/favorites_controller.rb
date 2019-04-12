class FavoritesController < ApplicationController
  def create
    if logged_in? and current_person.customer?
      fav_params = params.require(:favorite).permit(:content_id, :content_type)
      @favorite = Favorite.new(fav_params)
      @favorite.customer_id = current_person.user.id
      @favorite.save
      redirect_to request.referer
    end
  end
  
  def destroy
    @favorite = Favorite.find(params[:id])
    if logged_in? and current_person.customer? and @favorite.customer == current_person.user
      @favorite.destroy
    end
    redirect_to request.referer
  end
end
