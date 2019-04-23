class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  #Authorization
  before_action :logged_in_customer

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    @customer = @subscription.customer
    @show = @subscription.show
    
    # Verify current customer
    if current_person.user != @customer
      return
    end
    
    # Check if customer already has sub
    if !@customer.has_subscription?(@show)
      # Check if customer can subscribe without purchase
      if @customer.open_slots?
        if @subscription.save
          redirect_to @show
        end
      else
        # Check if customer wants to purchase
        if params[:purchase] == true
          if @subscription.save
            # Purchase another slot
            @customer.slots += 1
            @customer.save
            redirect_to @show
          end
        end
      end
    end
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_back(fallback_location: root_url) }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:customer_id, :show_id, :current_episode, :cancel)
    end
end
