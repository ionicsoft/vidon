class InvoicesController < ApplicationController
  def create
    @invoice = Invoice.new(invoice_params)
    session[:return_to] ||= request.referer

    if @invoice.save
      render json: {status: true}
    else
      render json: {status: false}
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:payment_id, :amount, :description)
    end
end
