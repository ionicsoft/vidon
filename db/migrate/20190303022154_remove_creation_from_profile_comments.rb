class RemoveCreationFromProfileComments < ActiveRecord::Migration[5.1]
  def change
    remove_column :profile_comments, :creation
    remove_column :video_comments, :creation
  end
end
