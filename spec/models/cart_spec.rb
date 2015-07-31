require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '#add_items' do
    before(:all) do
      @cart = Cart.create
    end

    it 'adds item when is not present' do
      item = create(:item)
      @cart.add_item(item.id)
      expect(@cart.order_items.any? { |oi| oi.item == item }).to eq(true)
    end

    it 'increases quanity when item is present' do
      item = create(:item)
      @cart.add_item(item.id)
      @cart.add_item(item.id)
      expect(@cart.order_items.find_all{ |oi| oi.item == item }.count).to eq(1)
      expect(@cart.order_items.find{ |oi| oi.item == item }.quantity).to eq(2)
    end
  end
end
