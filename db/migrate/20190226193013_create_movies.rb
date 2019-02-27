class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.integer :video_id
      t.integer :producer_id

      t.timestamps
    end
  end
end
