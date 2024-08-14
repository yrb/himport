class AddMetadataToFloorPlans < ActiveRecord::Migration[7.2]
  def change
    add_column :floor_plans, :metadata, :json
  end
end
