class WatchHistoriesController < ApplicationController
  before_action :logged_in_customer
  
  # Used to display a user's video watch history
  # GET /watch_histories
  def index
    # Get history for user sorted by most recent
    @histories = current_person.user.watch_histories.includes(:video).order(updated_at: :desc)
  end
  
  # POST /watch_histories/:id
  def update
    @history = WatchHistory.find(params[:id])
    if current_person.user == @history.customer
      @history.progress = params[:watch_history][:progress]
      @history.save
    end
  end
end
