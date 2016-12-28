class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.date :publish_date
      t.integer :pages
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :books, :categories
    add_index :books, [:category_id, :created_at]
  end
end
