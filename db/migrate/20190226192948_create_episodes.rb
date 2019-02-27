class CreateEpisodes < ActiveRecord::Migration[5.1]
  def change
    create_table :episodes do |t|
      t.integer :season
      t.integer :show_id
      t.integer :episode
      t.integer :absolute_episode
      t.integer :video_id

      t.timestamps
    end
  end
end
