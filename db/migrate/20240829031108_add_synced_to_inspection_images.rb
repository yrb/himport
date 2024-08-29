class AddSyncedToInspectionImages < ActiveRecord::Migration[7.2]
  def change
    add_column :inspection_images, :synced, :boolean
  end
end
