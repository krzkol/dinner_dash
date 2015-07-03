require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.new(title: 'baked chicken', description: 'delicious chicken', price: 2.50) }

  it 'has an array of categories' do
    expect(item.categories).to eq([])
  end
end
