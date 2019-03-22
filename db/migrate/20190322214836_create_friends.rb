class CreateFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :friends do |t|
      t.integer :customer_id
      t.integer :friend_id
    end
  end
end
