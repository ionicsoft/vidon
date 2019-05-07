class PaymentsController < ApplicationController
  # Load customer from database
  before_action :set_payment
  # Check authorization
  before_action :logged_in_customer
  before_action :correct_customer
  
  def edit
  end
  
  def update
    if @payment.update(payment_params)
      redirect_to root_url, notice: "Payment information successfully updated."
    else
      render :edit
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Check is logged in customer matches
    def correct_customer
      redirect_to(root_url) unless current_user?(@payment.customer)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:card_name, :card_num, :cvc, :expiration)
    end
end
