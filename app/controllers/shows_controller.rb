class ShowsController < ApplicationController
  before_action :set_show, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # GET /shows/1
  # GET /shows/1.json
  def show
    if !params[:update].nil? and current_person.customer?
      # Update subscription for customer
      sub = current_person.user.subscriptions.find_by(show: @show)
      sub.current_episode = @show.episodes.size
      sub.save
      # Set last video as completed
      history = WatchHistory.find params[:update]
      if !history.nil? and history.customer == current_person.user
        history.completed = true
        history.save
      end
    end
  end

  # GET /shows/new
  def new
    @show = Show.new
  end

  # GET /shows/1/edit
  def edit
  end

  # POST /shows
  # POST /shows.json
  def create
    @show = Show.new(show_params)

    if @show.save
      redirect_to @show, notice: 'Show was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /shows/1
  # PATCH/PUT /shows/1.json
  def update
    if @show.update(show_params)
      redirect_to @show, notice: 'Show was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /shows/1
  # DELETE /shows/1.json
  def destroy
    @show.destroy
    redirect_to pro_shows_path, notice: 'Show was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show
      @show = Show.find(params[:id])
    end
    
    # Check current user has permision to edit
    def correct_producer
      redirect_to root_url unless @show.valid_producer? current_person.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_params
      params.require(:show).permit(:name, :producer_id, :description, :promo_image)
    end
end
