require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  it 'should be valid' do
    expect(order).to be_valid
  end

  it 'should refer to user' do
    expect(order).to respond_to(:user)
  end

  it 'has an array of items' do
    expect(order.order_items).to eq([])
  end

  it 'is not valid without user' do
    order.user = nil
    expect(order).to_not be_valid
  end
end
