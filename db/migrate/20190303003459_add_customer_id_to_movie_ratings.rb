class AddCustomerIdToMovieRatings < ActiveRecord::Migration[5.1]
  def change
    add_column :movie_ratings, :customer_id, :integer
  end
end
