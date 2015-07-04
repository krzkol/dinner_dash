class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.references :item, index: true
      t.references :cart, index: true
      t.integer :price
    end
    add_foreign_key :order_items, :items
    add_foreign_key :order_items, :carts
  end
end
