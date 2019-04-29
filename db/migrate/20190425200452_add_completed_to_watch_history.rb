class AddCompletedToWatchHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :watch_histories, :completed, :boolean, default: false
  end
end
