class AddHostToImportProject < ActiveRecord::Migration[7.2]
  def change
    add_column :import_projects, :host, :string
  end
end
