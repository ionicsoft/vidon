class FixDatabase < ActiveRecord::Migration[5.2]
  def change
    # Remove unused columns
    remove_column :customers, :person_id, :integer
    remove_column :customers, :payment_id, :integer
    remove_column :producers, :person_id, :integer
    remove_column :episodes, :video_id, :integer
    remove_column :movies, :video_id, :integer
    remove_column :videos, :filename, :string

    # Add indices
    add_index :episodes, :show_id
    add_index :movie_actors, :movie_id
    add_index :movie_genres, :movie_id
    add_index :movie_ratings, :customer_id
    add_index :movie_ratings, :movie_id
    add_index :movies, :producer_id
    add_index :people, :username, unique: true
    add_index :payments, :customer_id
    add_index :profile_comments, :customer_id
    add_index :profile_comments, :commentor_id
    add_index :show_actors, :show_id
    add_index :show_genres, :show_id
    add_index :show_ratings, :show_id
    add_index :show_ratings, :customer_id
    add_index :shows, :producer_id
    add_index :video_comments, :video_id
    add_index :video_comments, :customer_id
    
    # Changes to data types
    reversible do |dir|
      change_table :profile_comments do |t|
        dir.up   { t.change :comment, :text }
        dir.down { t.change :comment, :string }
      end
      change_table :video_comments do |t|
        dir.up   { t.change :comment, :text }
        dir.down { t.change :comment, :string }
      end
      change_table :shows do |t|
        dir.up   { t.change :description, :text }
        dir.down { t.change :description, :string }
      end
      change_table :videos do |t|
        dir.up   { t.change :description, :text }
        dir.down { t.change :description, :string }
      end
    end
  end
end
