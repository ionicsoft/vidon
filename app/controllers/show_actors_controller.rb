class ShowActorsController < ApplicationController
  before_action :set_show_actor, only: [:show, :edit, :update, :destroy]

  # GET /show_actors
  # GET /show_actors.json
  def index
    @show_actors = ShowActor.all
  end

  # GET /show_actors/1
  # GET /show_actors/1.json
  def show
  end

  # GET /show_actors/new
  def new
    @show_actor = ShowActor.new
  end

  # GET /show_actors/1/edit
  def edit
  end

  # POST /show_actors
  # POST /show_actors.json
  def create
    @show_actor = ShowActor.new(show_actor_params)

    respond_to do |format|
      if @show_actor.save
        format.html { redirect_to @show_actor, notice: 'Show actor was successfully created.' }
        format.json { render :show, status: :created, location: @show_actor }
      else
        format.html { render :new }
        format.json { render json: @show_actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /show_actors/1
  # PATCH/PUT /show_actors/1.json
  def update
    respond_to do |format|
      if @show_actor.update(show_actor_params)
        format.html { redirect_to @show_actor, notice: 'Show actor was successfully updated.' }
        format.json { render :show, status: :ok, location: @show_actor }
      else
        format.html { render :edit }
        format.json { render json: @show_actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /show_actors/1
  # DELETE /show_actors/1.json
  def destroy
    @show_actor.destroy
    respond_to do |format|
      format.html { redirect_to show_actors_url, notice: 'Show actor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_actor
      @show_actor = ShowActor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_actor_params
      params.require(:show_actor).permit(:name, :show_id)
    end
end
