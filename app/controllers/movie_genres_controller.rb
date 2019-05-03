class MovieGenresController < ApplicationController
  before_action :set_movie_genre, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # POST /movie_genres
  # POST /movie_genres.json
  def create
    @movie_genre = MovieGenre.new(movie_genre_params)
    session[:return_to] ||= request.referer

    if @movie_genre.save
      redirect_to session.delete(:return_to), notice: 'Movie genre was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /movie_genres/1
  # PATCH/PUT /movie_genres/1.json
  def update
    @mov = Movie.find(@movie_genre.movie_id)
    if @movie_genre.update(movie_genre_params)
      redirect_to @mov, notice: 'Movie genre was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /movie_genres/1
  # DELETE /movie_genres/1.json
  def destroy
    session[:return_to] ||= request.referer
    @movie_genre.destroy
    redirect_to session.delete(:return_to), notice: 'Movie genre was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_genre
      @movie_genre = MovieGenre.find(params[:id])
    end

    # Check current user has permision to edit
    def correct_producer
      redirect_to root_url unless @movie_genre.valid_producer? current_person.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_genre_params
      params.require(:movie_genre).permit(:genre, :movie_id)
    end
end
