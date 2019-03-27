namespace :update do
  
  desc "SUBSCRIPTION_RENEWAL"
  task subscription_renewal: :environment do
    puts "Updating user subscriptions..."
    Customer.where(renewal_date: Date.current).find_each do |customer|
      customer.subscriptions.where(cancel: true).destroy_all
      customer.renewal_date += 30.days
      customer.save
    end
    puts "#{Time.now} - Done."
  end
end
