class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]
  # Check authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # GET /episodes/new
  def new
    @episode = Episode.new
    @episode.video = Video.new
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes
  # POST /episodes.json
  def create
    @episode = Episode.new(episode_params)

    if @episode.save
      redirect_to @episode.show, notice: 'Episode was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /episodes/1
  # PATCH/PUT /episodes/1.json
  def update
    if @episode.update(episode_params)
      redirect_to @episode.show, notice: 'Episode was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    @episode.destroy
    redirect_to episodes_url, notice: 'Episode was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end
    
    # Check producer has permission to edit
    def correct_producer
      redirect_to root_url unless @episode.valid_producer? current_person.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:season, :show_id, :episode, :absolute_episode, 
      :video_attributes => [:title, :description, :clip, :thumbnail])
    end
end
