class CreateShows < ActiveRecord::Migration[5.1]
  def change
    create_table :shows do |t|
      t.string :name
      t.integer :producer_id

      t.timestamps
    end
  end
end
