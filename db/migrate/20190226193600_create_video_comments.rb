class CreateVideoComments < ActiveRecord::Migration[5.1]
  def change
    create_table :video_comments do |t|
      t.datetime :creation
      t.integer :video_id
      t.integer :customer_id
      t.string :comment

      t.timestamps
    end
  end
end
