class AddDeviseToUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_table :users do |t|

      t.change :email, :string, null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.change :name, :string, null: false

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email
    end

    add_index :users, :confirmation_token,   unique: true

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
