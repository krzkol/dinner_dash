require 'rails_helper'

describe CartHelper do
  describe '#cart_has_items?' do
    it 'return false for empty cart' do
      expect(helper.cart_has_items?).to be(false)
    end

    it 'return true for non-empty cart' do
      cart = Cart.create
      item = create(:item)
      order_item = OrderItem.create(item: item, item_group: cart, price: item.price)
      cart.order_items << order_item
      assign(:cart, cart)
      expect(helper.cart_has_items?).to be
    end
  end
end
