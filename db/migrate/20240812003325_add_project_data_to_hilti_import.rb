class AddProjectDataToHiltiImport < ActiveRecord::Migration[7.2]
  def change
    add_column :hilti_imports, :project_data, :text
  end
end
