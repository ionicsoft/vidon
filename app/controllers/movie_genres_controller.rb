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

    respond_to do |format|
      if @movie_genre.save
        format.html { redirect_to session.delete(:return_to), notice: 'Movie genre was successfully created.' }
        format.json { render :show, status: :created, location: @movie_genre }
      else
        format.html { render :new }
        format.json { render json: @movie_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_genres/1
  # PATCH/PUT /movie_genres/1.json
  def update
    respond_to do |format|
      @mov = Movie.find(@movie_genre.movie_id)
      if @movie_genre.update(movie_genre_params)
        format.html { redirect_to @mov, notice: 'Movie genre was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie_genre }
      else
        format.html { render :edit }
        format.json { render json: @movie_genre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_genres/1
  # DELETE /movie_genres/1.json
  def destroy
    session[:return_to] ||= request.referer
    @movie_genre.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: 'Movie genre was successfully destroyed.' }
      format.json { head :no_content }
    end
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
