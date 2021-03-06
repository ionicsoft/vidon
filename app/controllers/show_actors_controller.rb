class ShowActorsController < ApplicationController
  before_action :set_show_actor, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:create, :edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # POST /show_actors
  # POST /show_actors.json
  def create
    @show_actor = ShowActor.new(show_actor_params)
    session[:return_to] ||= request.referer

    respond_to do |format|
      if @show_actor.save
        format.html { redirect_to session.delete(:return_to), notice: 'Show actor was successfully created.' }
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
      @show = Show.find(@show_actor.show_id)
      if @show_actor.update(show_actor_params)
        format.html { redirect_to @show, notice: 'Show actor was successfully updated.' }
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
    session[:return_to] ||= request.referer
    @show_actor.destroy
    respond_to do |format|
      format.html { redirect_to session.delete(:return_to), notice: 'Show actor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_actor
      @show_actor = ShowActor.find(params[:id])
    end
    
    # Check current user has permision to edit
    def correct_producer
      redirect_to root_url unless @show_actor.valid_producer? current_person.user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def show_actor_params
      params.require(:show_actor).permit(:name, :show_id)
    end
end
