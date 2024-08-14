class AddBuildingToHiltiProject < ActiveRecord::Migration[7.2]
  def change
    add_column :hilti_projects, :building, :string
  end
end
