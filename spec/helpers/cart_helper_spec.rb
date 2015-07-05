require 'rails_helper'

describe CartHelper do
  describe '#cart_has_items?' do
    it 'return false for empty cart' do
      expect(helper.cart_has_items?).to be(false)
    end

    it 'return true for non-empty cart' do
      cart = Cart.create
      item = Item.create(title: 'chicken', description: 'delicious chicken', price: 5.70)
      order_item = OrderItem.create(item: item, cart: cart, price: item.price, quantity: 1)
      cart.order_items << order_item
      assign(:cart, cart)
      expect(helper.cart_has_items?).to be
    end
  end
end
