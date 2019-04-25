class WatchHistoriesController < ApplicationController
  before_action :logged_in_customer
  
  def index
    @histories = current_person.user.watch_histories.includes(:video).order(updated_at: :desc)
  end
end
