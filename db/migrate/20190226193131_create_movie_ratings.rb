class CreateMovieRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :movie_ratings do |t|
      t.integer :movie_id
      t.integer :rating

      t.timestamps
    end
  end
end
