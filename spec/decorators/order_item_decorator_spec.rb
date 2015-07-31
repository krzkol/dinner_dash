require 'rails_helper'

describe OrderItemDecorator do
  describe '#price' do
    it 'display price with precision and currency' do
      order_item = build(:order_item)
      expect(order_item.decorate.price).to eq("$2.00")
    end
  end

  describe '#total' do
    it 'display total with precision and currency' do
      order_item = build(:order_item, quantity: 3)
      expect(order_item.decorate.total).to eq("$6.00")
    end
  end
end
