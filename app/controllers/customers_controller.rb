class CustomersController < ApplicationController
  # Load customer from database
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  # Check authorization
  before_action :logged_in_any, only: [:show]
  before_action :logged_in_customer, only: [:edit, :update, :destroy], except: [:create]
  before_action :correct_customer, only: [:edit, :update, :destroy]

  # GET /customers/1
  # GET /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
    @customer.person = Person.new
    @customer.payment = Payment.new
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      @customer.person.send_activation_email
      Invoice.create(:payment_id => @customer.payment.id, :amount => 10.00, :description => "Vidon Monthly Subscription Fee")
      redirect_to login_path, notice: 'Please check your email to activate your account.'
    else
      render :new
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    redirect_to customers_url, notice: 'Customer was successfully destroyed.'
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Check is logged in customer matches
    def correct_customer
      redirect_to(root_url) unless current_user?(@customer)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def customer_params
      params.require(:customer).permit(:person_attributes => [:avatar, 
        :username, :password, :password_confirmation, :email, :first_name,
        :last_name], :payment_attributes => [:card_name, :card_num, :cvc, :expiration])
    end
end
