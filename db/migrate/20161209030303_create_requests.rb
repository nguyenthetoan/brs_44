class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.string :title
      t.text :content
      t.references :user, index: true
      t.timestamps null: false
    end
    add_foreign_key :requests, :users
    add_index :requests, [:user_id, :created_at]
  end
end
