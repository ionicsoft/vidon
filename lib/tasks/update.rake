namespace :update do
  
  desc "SUBSCRIPTION_RENEWAL"
  task subscription_renewal: :environment do
    Customer.where(renewal_date: Date.current).each
      Subscription.where(cancel: true).destroy_all
  end

end
