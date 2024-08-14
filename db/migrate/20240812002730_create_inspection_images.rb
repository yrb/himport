class CreateInspectionImages < ActiveRecord::Migration[7.2]
  def change
    create_table :inspection_images do |t|
      t.belongs_to :hilti_import, null: false, foreign_key: true
      t.string :reference, index: {unique: true}, null: false

      t.timestamps
    end
  end
end
