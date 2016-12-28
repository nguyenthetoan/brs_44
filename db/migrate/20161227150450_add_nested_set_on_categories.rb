class AddNestedSetOnCategories < ActiveRecord::Migration[5.0]
  def change
    change_table :categories do |t|
      t.integer :depth, null: false, default: 0
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
    end
    add_index :categories, :name
  end
end
