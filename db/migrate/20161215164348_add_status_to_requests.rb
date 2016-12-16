class AddStatusToRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :requests, :status, :integer
    change_column_default :requests, :status, nil
  end
end
