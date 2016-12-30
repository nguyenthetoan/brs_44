class AddPublisherToAuthors < ActiveRecord::Migration[5.0]
  def change
    add_reference :authors, :publisher, foreign_key: true, index: true
  end
end
