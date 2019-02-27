class ShowRatingsController < ApplicationController
  before_action :set_show_rating, only: [:show, :edit, :update, :destroy]

  # GET /show_ratings
  # GET /show_ratings.json
  def index
    @show_ratings = ShowRating.all
  end

  # GET /show_ratings/1
  # GET /show_ratings/1.json
  def show
  end

  # GET /show_ratings/new
  def new
    @show_rating = ShowRating.new
  end

  # GET /show_ratings/1/edit
  def edit
  end

  # POST /show_ratings
  # POST /show_ratings.json
  def create
    @show_rating = ShowRating.new(show_rating_params)

    respond_to do |format|
      if @show_rating.save
        format.html { redirect_to @show_rating, notice: 'Show rating was successfully created.' }
        format.json { render :show, status: :created, location: @show_rating }
      else
        format.html { render :new }
        format.json { render json: @show_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /show_ratings/1
  # PATCH/PUT /show_ratings/1.json
  def update
    respond_to do |format|
      if @show_rating.update(show_rating_params)
        format.html { redirect_to @show_rating, notice: 'Show rating was successfully updated.' }
        format.json { render :show, status: :ok, location: @show_rating }
      else
        format.html { render :edit }
        format.json { render json: @show_rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /show_ratings/1
  # DELETE /show_ratings/1.json
  def destroy
    @show_rating.destroy
    respond_to do |format|
      format.html { redirect_to show_ratings_url, notice: 'Show rating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_rating
      @show_rating = ShowRating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_rating_params
      params.require(:show_rating).permit(:rating, :show_id)
    end
end
