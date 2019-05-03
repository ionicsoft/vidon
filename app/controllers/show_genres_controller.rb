class ShowGenresController < ApplicationController
  before_action :set_show_genre, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # POST /show_genres
  # POST /show_genres.json
  def create
    @show_genre = ShowGenre.new(show_genre_params)
    session[:return_to] ||= request.referer

    if @show_genre.save
      redirect_to session.delete(:return_to), notice: 'Show genre was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /show_genres/1
  # PATCH/PUT /show_genres/1.json
  def update
    @show = Show.find(@show_genre.show_id)
    if @show_genre.update(show_genre_params)
      redirect_to @show, notice: 'Show genre was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /show_genres/1
  # DELETE /show_genres/1.json
  def destroy
    session[:return_to] ||= request.referer
    @show_genre.destroy
    redirect_to session.delete(:return_to), notice: 'Show genre was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_genre
      @show_genre = ShowGenre.find(params[:id])
    end
    
    # Check current user has permision to edit
    def correct_producer
      redirect_to root_url unless @show_genre.valid_producer? current_person.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_genre_params
      params.require(:show_genre).permit(:show_id, :genre)
    end
end
