class CreateHiltiImports < ActiveRecord::Migration[7.2]
  def change
    create_table :hilti_imports do |t|
      t.string :label
      t.boolean :processed
      t.datetime :sent_at
      t.text :projects
      t.text :penetrations

      t.timestamps
    end
  end
end
