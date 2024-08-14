class AddImportProjectToHiltiImport < ActiveRecord::Migration[7.2]
  def change
    add_reference :hilti_imports, :import_project, null: false, foreign_key: true
  end
end
