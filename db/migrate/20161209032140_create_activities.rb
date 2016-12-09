class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :activities do |t|
      t.string :activatable_type
      t.integer :activatable_id
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
    add_index :activities, [:activatable_type, :activatable_id]
  end
end
