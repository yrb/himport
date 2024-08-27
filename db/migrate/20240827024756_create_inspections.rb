class CreateInspections < ActiveRecord::Migration[7.2]
  def change
    create_table :inspections do |t|
      t.references :hilti_import, null: false, foreign_key: true
      t.references :hilti_project, null: false, foreign_key: true
      t.string :reference
      t.string :project_id
      t.string :category_id
      t.text :penetration
      t.json :marker
      t.string :clarinspect_id
      t.json :clarinspect_inspection

      t.timestamps
    end
  end
end
