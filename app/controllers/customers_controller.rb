class CustomersController < ApplicationController
  # Load customer from database
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  # Check authorization
  before_action :logged_in_customer, only: [:edit, :update, :destroy]
  before_action :correct_customer, only: [:edit, :update, :destroy]

  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all
  end

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

  # GET /customers/1/edit
  def edit
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        PersonMailer.account_activation(@customer.person).deliver_now
        Invoice.create(:payment_id => @customer.payment.id, :amount => 10.00, :description => "Vidon Monthly Subscription Fee")
        format.html { redirect_to login_path, notice: 'Please check your email to activate your account.' }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1
  # PATCH/PUT /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer.destroy
    respond_to do |format|
      format.html { redirect_to customers_url, notice: 'Customer was successfully destroyed.' }
      format.json { head :no_content }
    end
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
