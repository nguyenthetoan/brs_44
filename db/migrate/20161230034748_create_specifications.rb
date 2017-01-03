class CreateSpecifications < ActiveRecord::Migration[5.0]
  def change
    create_table :specifications do |t|
      t.string :specification_name
      t.string :specification_value
      t.references :book, index: true
    end
  end
end
