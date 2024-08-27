class AddCategoryToHiltiProject < ActiveRecord::Migration[7.2]
  def change
    add_column :hilti_projects, :category_id, :string
    add_column :hilti_projects, :category_name, :string
    remove_index :hilti_projects, :reference
    add_index :hilti_projects, [:reference, :category_id]
  end
end
