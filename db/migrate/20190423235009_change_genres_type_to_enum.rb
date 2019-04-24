class ChangeGenresTypeToEnum < ActiveRecord::Migration[5.2]
  def up
    change_column :movie_genres, :genre, :integer
    change_column :show_genres, :genre, :integer
  end
  
  def down
    change_column :movie_genres, :genre, :string
    change_column :show_genres, :genre, :string
  end
end
