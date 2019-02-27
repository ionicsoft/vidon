class CreateShowGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :show_genres do |t|
      t.integer :show_id
      t.string :genre

      t.timestamps
    end
  end
end
