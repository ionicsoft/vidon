class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  #Authorization
  before_action :logged_in_any, only: [:show]
  before_action :check_permission, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end
  

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
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
