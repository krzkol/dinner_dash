require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before(:all) do
    @order = build(:order)
    @order_item = build(:order_item)
  end

  it 'should be valid' do
    @order_item.item_group = @order
    expect(@order_item).to be_valid
  end

  it 'is not valid without an item' do
    @order_item.item = nil
    expect(@order_item).to_not be_valid
  end

  it 'should belong to group of items' do
    @order_item.item_group_id = nil
    expect(@order_item).to_not be_valid
  end

  describe '#total' do
    it 'returns price multiplied by quantity' do
      @order_item = build(:order_item, quantity: 3)
      expect(@order_item.total).to eq(@order_item.price * @order_item.quantity)
    end
  end
end
