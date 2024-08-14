class AddClarinspectIdToInspectionImage < ActiveRecord::Migration[7.2]
  def change
    add_column :inspection_images, :clarinspect_id, :string
  end
end
