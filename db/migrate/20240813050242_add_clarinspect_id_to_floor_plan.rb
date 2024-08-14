class AddClarinspectIdToFloorPlan < ActiveRecord::Migration[7.2]
  def change
    add_column :floor_plans, :clarinspect_id, :string
  end
end
