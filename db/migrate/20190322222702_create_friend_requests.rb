class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.references :customer, foreign_key: true
      t.references :requester, foreign_key: false
      
      t.timestamps
    end
    add_foreign_key :friend_requests, :customers, column: :requester_id
  end
end
