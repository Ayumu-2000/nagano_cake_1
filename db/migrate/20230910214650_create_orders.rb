class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :delivery_name, null: false
      t.integer :delivery_price, null: false
      t.integer :payment_price, null: false
      t.integer :payment_method, null: false

      t.timestamps
    end
  end
end
