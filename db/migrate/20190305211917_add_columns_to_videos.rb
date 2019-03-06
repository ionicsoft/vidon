class AddColumnsToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :content_id, :integer
    add_column :videos, :content_type, :string
  end
end
