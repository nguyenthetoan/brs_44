class CreateChatrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chatrooms do |t|
      t.string :title
      t.integer :host_id
      t.integer :guest_id

    end
    add_index :chatrooms, :host_id
    add_index :chatrooms, :guest_id
    add_index :chatrooms, [:host_id, :guest_id], unique: true
  end
end
