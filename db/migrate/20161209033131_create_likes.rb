class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes do |t|
      t.boolean :like
      t.integer :likable_id
      t.string :likable_type
      t.references :user, foreign_key: true, index: true

      t.timestamps null: false
    end
    add_index :likes, [:likable_type, :likable_id]
  end
end
