class AddCountersToModels < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :subscriptions_count, :integer
  end
end
