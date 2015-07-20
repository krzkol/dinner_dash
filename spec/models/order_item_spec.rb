require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:order) { build(:order) }
  let(:order_item) { build(:order_item) }

  it 'should be valid' do
    order_item.item_group = order
    expect(order_item).to be_valid
  end

  it 'is not valid without an item' do
    order_item.item = nil
    expect(order_item).to_not be_valid
  end

  it 'should belong to group of items' do
    order_item.item_group_id = nil
    expect(order_item).to_not be_valid
  end
end
