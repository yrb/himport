class AddClarinspectAssetIdToInspectionImage < ActiveRecord::Migration[7.2]
  def change
    rename_column :inspection_images, :clarinspect_id, :clarinspect_asset_id
  end
end