require 'rails_helper'

describe OrderDecorator do

  describe '#created_at' do
    it 'returns created_at with custom formatting' do
      order = create(:order).decorate
      expect(order.created_at).to eq(order.attributes["created_at"].strftime("%d %b %Y at %H:%M:%S"))
    end
  end

  describe '#updated_at' do
    it 'returns updated_at with custom formatting' do
      order = create(:order).decorate
      expect(order.updated_at).to eq(order.attributes["updated_at"].strftime("%d %b %Y at %H:%M:%S"))
    end
  end

  describe '#total' do
    it 'returns total of order with currency' do
      item1 = Item.create(title: 'Chips', description: 'Tasty chips', price: 2.00)
      item2 = Item.create(title: 'Fish', description: 'Fresh chips', price: 3.25)
      order = Order.new(user_id: 1)
      order.order_items << OrderItem.new(price: item1.price, item_id: item1.id)
      order.order_items << OrderItem.new(price: item2.price, item_id: item2.id, quantity: 2)
      order.save
      expect(order.decorate.total).to eq("$8.50")
    end
  end
end
