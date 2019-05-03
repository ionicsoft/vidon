class ShowActorsController < ApplicationController
  before_action :set_show_actor, only: [:destroy]
  # Authorization
  before_action :logged_in_producer
  before_action :correct_producer, only: [:destroy]

  # POST /show_actors
  # POST /show_actors.json
  def create
    @show_actor = ShowActor.new(show_actor_params)
    session[:return_to] ||= request.referer

    if @show_actor.save
      redirect_to session.delete(:return_to), notice: 'Show actor was successfully created.'
    else
      render :new
    end
  end

  # DELETE /show_actors/1
  # DELETE /show_actors/1.json
  def destroy
    session[:return_to] ||= request.referer
    @show_actor.destroy
    redirect_to session.delete(:return_to), notice: 'Show actor was successfully destroyed.'
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
