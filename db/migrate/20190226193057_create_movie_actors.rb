class CreateMovieActors < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_actors do |t|
      t.string :name
      t.integer :movie_id

      t.timestamps
    end
  end
end
