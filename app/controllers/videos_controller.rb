class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  #Authorization
  before_action :logged_in_any, only: [:show]
  before_action :check_permission, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # GET /videos/1
  # GET /videos/1.json
  def show
    if current_person.customer?
      # Create or update watch history for customer
      @watch_history = WatchHistory.find_or_create_by video: @video, customer: current_person.user
      @watch_history.touch
      
      # Update subscription if needed
      if @video.episode?
        sub = current_person.user.subscriptions.find_by(show: @video.content.show)
        if sub.current_episode < @video.content.absolute_episode
          sub.current_episode = @video.content.absolute_episode
          sub.save
        end
      end
      
      # Set previous watch history as completed
      prev = @video.prev_video
      if !prev.nil?
        last_watched = WatchHistory.find_or_create_by video: prev, customer: current_person.user
        last_watched.completed = true
        last_watched.save
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end
    
    # Check if user has permission to view video
    def check_permission
      if current_person.producer?
        # Check if video is owned by producer
        correct_producer
      else
        # Check if customer has a valid subscription or rental
        @customer = current_person.user
        if @video.episode?
          unless @customer.has_subscription?(@video.content_parent)
            flash[:danger] = "Must subscribe first to view content"
            redirect_to @video.content_parent
          end
        else
          unless @customer.rentals.find_by(movie_id: @video.content_parent.id)
            flash[:danger] = "Must rent first to view content"
            redirect_to @video.content_parent
          end
        end
      end
    end
    
    # Check current user has permision to edit
    def correct_producer
      redirect_to root_url unless @video.valid_producer? current_person.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :clip, :thumbnail, :content_id, :content_type)
    end
end
