class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :customer_id
      t.integer :show_id
      t.integer :current_episode

      t.timestamps
    end
  end
end
