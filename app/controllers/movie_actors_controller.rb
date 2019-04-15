class MovieActorsController < ApplicationController
  before_action :set_movie_actor, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]

  # GET /movie_actors
  # GET /movie_actors.json
  def index
    @movie_actors = MovieActor.all
  end

  # GET /movie_actors/1
  # GET /movie_actors/1.json
  def show
  end

  # GET /movie_actors/new
  def new
    @movie_actor = MovieActor.new
  end

  # GET /movie_actors/1/edit
  def edit
  end

  # POST /movie_actors
  # POST /movie_actors.json
  def create
    @movie_actor = MovieActor.new(movie_actor_params)

    respond_to do |format|
      if @movie_actor.save
        format.html { redirect_to @movie_actor, notice: 'Movie actor was successfully created.' }
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
      if @movie_actor.update(movie_actor_params)
        format.html { redirect_to @movie_actor, notice: 'Movie actor was successfully updated.' }
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
    @movie_actor.destroy
    respond_to do |format|
      format.html { redirect_to movie_actors_url, notice: 'Movie actor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_actor
      @movie_actor = MovieActor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_actor_params
      params.require(:movie_actor).permit(:name, :movie_id)
    end
end
