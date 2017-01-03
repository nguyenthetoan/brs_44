class AddPublisherToBooks < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :publisher, foreign_key: true, index: true
  end
end
