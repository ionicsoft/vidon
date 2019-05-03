class ProducersController < ApplicationController
  before_action :set_producer, only: [:show, :edit, :update, :destroy]
  # Check authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_producer, only: [:edit, :update, :destroy]
  before_action :correct_producer, only: [:edit, :update, :destroy]

  # GET /producers/new
  def new
    @producer = Producer.new
    @producer.person = Person.new
  end

  # POST /producers
  # POST /producers.json
  def create
    @producer = Producer.new(producer_params)

    if @producer.save
      PersonMailer.account_activation(@producer.person).deliver_now
      redirect_to login_path, notice: 'Please check your email to activate your account.'
    else
      render :new
    end
  end

  # DELETE /producers/1
  # DELETE /producers/1.json
  def destroy
    @producer.destroy
    redirect_to producers_url, notice: 'Producer was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producer
      @producer = Producer.find(params[:id])
    end
    
    # Check if logged in producer matches
    def correct_producer
      redirect_to(root_url) unless current_user?(@producer)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producer_params
      params.require(:producer).permit(:company_name,:person_attributes => [:avatar, :username, :password, 
      :password_confirmation, :email])
    end
end
