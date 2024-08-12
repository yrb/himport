class CreateTestReports < ActiveRecord::Migration[7.2]
  def change
    create_table :test_reports do |t|
      t.belongs_to :hilti_import, null: false, foreign_key: true
      t.string :reference

      t.timestamps
    end
  end
end
