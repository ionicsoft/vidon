class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  # Authorization
  before_action :logged_in_any, except: [:create]
  before_action :correct_person, only: [:edit, :update, :destroy]

  # GET /people/1/edit
  def edit
  end

  # PATCH/PUT /people/1
  # PATCH/PUT /people/1.json
  def update
    if @person.update(person_params)
      redirect_to @person.user, notice: 'Person was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person
      @person = Person.find(params[:id])
    end
    
    # Verify current user has permission to edit
    def correct_person
      redirect_to root_url unless current_person == @person
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:avatar, :username, :email, :password, :password_confirmation, :first_name, :last_name, :user_id, :user_type)
    end
end
