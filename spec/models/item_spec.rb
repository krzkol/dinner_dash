require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { build(:item) }

  it 'has an array of categories' do
    expect(item.categories).to eq([])
  end

  describe '.items in menu' do
    it 'returns items which are not retired' do
      item = create(:item, retired: true)
      items = Item.items_in_menu
      expect(items.member?(item)).to eq(false)
    end
  end
end
