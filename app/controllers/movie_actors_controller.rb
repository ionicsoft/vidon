class MovieActorsController < ApplicationController
  before_action :set_movie_actor, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # POST /movie_actors
  # POST /movie_actors.json
  def create
    @movie_actor = MovieActor.new(movie_actor_params)
    session[:return_to] ||= request.referer

    respond_to do |format|
      if @movie_actor.save
        format.html { redirect_to session.delete(:return_to), notice: 'Movie actor was successfully created.' }
        format.json { render :show, status: :created, location: @movie_actor }
      else
        format.html { render :new }
        format.json { render json: @movie_actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movie_actors/1
  # PATCH/PUT /movie_actors/1.json
  def update
    respond_to do |format|
      @mov = Movie.find(@movie_actor.movie_id)
      if @movie_actor.update(movie_actor_params)
        format.html { redirect_to @mov, notice: 'Movie actor was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie_actor }
      else
        format.html { render :edit }
        format.json { render json: @movie_actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movie_actors/1
  # DELETE /movie_actors/1.json
  def destroy
    session[:return_to] ||= request.referer
    @movie_actor.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: 'Movie actor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_actor
      @movie_actor = MovieActor.find(params[:id])
    end
    
    # Check current user has permision to edit
    def correct_producer
      redirect_to root_url unless @movie_actor.valid_producer? current_person.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_actor_params
      params.require(:movie_actor).permit(:name, :movie_id)
    end
end
