class AddRenewalDateAndCancelFlag < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :renewal_date, :date
    add_column :subscriptions, :cancel, :boolean
  end
end
