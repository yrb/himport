class CreateImportProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :import_projects do |t|
      t.string :label
      t.integer :organisation_id
      t.json :template
      t.string :token

      t.timestamps
    end
  end
end
