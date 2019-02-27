class CreateMovieGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_genres do |t|
      t.string :genre
      t.integer :movie_id

      t.timestamps
    end
  end
end
