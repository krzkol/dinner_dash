class AddPolymorphicRelationToOrderItems < ActiveRecord::Migration
  def change
    remove_column :order_items, :cart_id
    add_column :order_items, :item_group_id, :integer, index: true
    add_column :order_items, :item_group_type, :string
  end
end
