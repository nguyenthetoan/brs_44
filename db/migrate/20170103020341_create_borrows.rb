class CreateBorrows < ActiveRecord::Migration[5.0]
  def change
    create_table :borrows do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.datetime :start_date
      t.datetime :due_date
      t.integer :status
    end
    add_index :borrows, [:user_id, :book_id]
  end
end
