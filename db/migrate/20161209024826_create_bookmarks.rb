class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.integer :read
      t.references :user, index: true
      t.references :book, index: true
      t.timestamps
    end
    add_index :bookmarks, [:user_id, :book_id]
  end
end
