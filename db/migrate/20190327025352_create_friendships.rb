class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :customer, foreign_key: true
      t.references :friend, foreign_key: false

      t.timestamps
    end
    add_foreign_key :friendships, :customers, column: :friend
  end
end
