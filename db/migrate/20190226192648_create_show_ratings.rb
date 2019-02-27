class CreateShowRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :show_ratings do |t|
      t.integer :rating
      t.integer :show_id

      t.timestamps
    end
  end
end
