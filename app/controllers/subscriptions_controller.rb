class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  #Authorization
  before_action :logged_in_customer

  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    @customer = @subscription.customer
    @show = @subscription.show
    
    # Verify current customer
    if current_person.user != @customer
      redirect_to root_url
      return
    end
    
    # Check if customer already has sub
    if !@customer.has_subscription?(@show)
      # Check if customer can subscribe without purchase
      if @customer.open_slots?
        if @subscription.save
          flash.notice = "Subscription added!"
        end
      else
        # Check if customer wants to purchase
        if params[:purchase] == "true"
          if @subscription.save
            # Purchase another slot
            Invoice.create(:payment_id => @customer.payment.id, :amount => 1.50, :description => "Additional subscription slot")
            @customer.slots += 1
            #byebug
            @customer.save
            flash.notice = "Subscription purchased!"
          end
        end
      end
    end
    
    redirect_to @show
  end

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  def update
    if @subscription.update(subscription_params)
      redirect_back(fallback_location: root_url)
    else
      #render :edit
      redirect_back(fallback_location: root_url)
      flash[:danger] = "Subscription not created"
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
