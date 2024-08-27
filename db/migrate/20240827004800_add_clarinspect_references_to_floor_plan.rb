class AddClarinspectReferencesToFloorPlan < ActiveRecord::Migration[7.2]
  def change
    add_column :floor_plans, :clarinspect_drawing_id, :string
    add_column :floor_plans, :clarinspect_asset_id, :string
    remove_column :floor_plans, :clarinspect_id
  end
end
