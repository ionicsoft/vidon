class AddCustomerIdToShowRatings < ActiveRecord::Migration[5.1]
  def change
    add_column :show_ratings, :customer_id, :integer
  end
end
