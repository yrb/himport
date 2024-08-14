class CreateHiltiProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :hilti_projects do |t|
      t.belongs_to :hilti_import, null: false, foreign_key: true
      t.string :reference, index: { unique: true }, null: false
      t.string :name
      t.string :address
      t.json :products
      t.json :approvals
      t.json :floor_plans
      t.json :fields
      t.json :configuration

      t.timestamps
    end
  end
end
