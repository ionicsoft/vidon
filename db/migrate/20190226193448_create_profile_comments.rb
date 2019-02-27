class CreateProfileComments < ActiveRecord::Migration[5.1]
  def change
    create_table :profile_comments do |t|
      t.datetime :creation
      t.integer :customer_id
      t.integer :commentor_id
      t.string :comment

      t.timestamps
    end
  end
end
