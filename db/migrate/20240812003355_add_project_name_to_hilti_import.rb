class AddProjectNameToHiltiImport < ActiveRecord::Migration[7.2]
  def change
    add_column :hilti_imports, :project_name, :string
  end
end
