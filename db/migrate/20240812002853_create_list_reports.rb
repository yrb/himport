class CreateListReports < ActiveRecord::Migration[7.2]
  def change
    create_table :list_reports do |t|
      t.belongs_to :hilti_import, null: false, foreign_key: true

      t.timestamps
    end
  end
end
