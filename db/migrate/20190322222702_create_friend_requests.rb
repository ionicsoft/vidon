class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :customer_id
      t.integer :requester_id
    end
  end
end
