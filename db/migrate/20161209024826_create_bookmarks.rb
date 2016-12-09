class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.string :read
      t.boolean :favorite

      t.timestamps
    end
    create_table :bookmarks_books, id: false do |t|
      t.belongs_to :book, index: true
      t.belongs_to :bookmark, index: true
    end
  end
end
