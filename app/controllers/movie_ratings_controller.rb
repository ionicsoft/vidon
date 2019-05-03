class MovieRatingsController < ApplicationController
  before_action :set_movie_rating, only: [:show, :edit, :update, :destroy]
  #Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_customer, only: [:create, :edit, :update, :destroy]

  # POST /movie_ratings
  # POST /movie_ratings.json
  def create
    @movie_rating = MovieRating.new(movie_rating_params)

    if @movie_rating.save
      redirect_to @movie_rating, notice: 'Movie rating was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /movie_ratings/1
  # PATCH/PUT /movie_ratings/1.json
  def update
    if @movie_rating.update(movie_rating_params)
      redirect_to @movie_rating, notice: 'Movie rating was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /movie_ratings/1
  # DELETE /movie_ratings/1.json
  def destroy
    @movie_rating.destroy
    redirect_to movie_ratings_url, notice: 'Movie rating was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_rating
      @movie_rating = MovieRating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_rating_params
      params.require(:movie_rating).permit(:movie_id, :rating, :customer_id)
    end
end
