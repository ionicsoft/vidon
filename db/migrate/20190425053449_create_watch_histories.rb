class CreateWatchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :watch_histories do |t|
      t.integer :progress, default: 0
      t.references :customer, foreign_key: true
      t.references :video, foreign_key: true

      t.timestamps
    end
  end
end
