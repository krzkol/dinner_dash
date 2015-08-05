require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @item = build(:item)
  end

  it 'is valid' do
    @item.title = 'Some meat'
    expect(@item).to be_valid
  end

  it 'is not valid without title' do
    @item.title = nil
    expect(@item).to_not be_valid
  end

  it 'is not valid without description' do
    @item.description = nil
    expect(@item).to_not be_valid
  end

  it 'is not valid without price' do
    @item.price = nil
    expect(@item).to_not be_valid
  end

  it 'is not valid with empty title' do
    @item.title = " "
    expect(@item).to_not be_valid
  end

  it 'is not valid with empty description' do
    @item.description = " "
    expect(@item).to_not be_valid
  end

  it 'is not valid with too short title' do
    @item.title = "AA"
    expect(@item).to_not be_valid
  end

  it 'is not valid with too short description' do
    @item.description = "ABCD"
    expect(@item).to_not be_valid
  end

  it 'is not valid with non-unique title' do
    @item.save
    category = build(:category)
    item = Item.new(title: @item.title, description: 'sth tasty', price: 2.50)
    item.categories << category
    expect(item).to_not be_valid
  end

  it 'is not valid with non-numeric price' do
    @item.price = "AAA"
    expect(@item).to_not be_valid
  end

  it 'is not valid with price equal to 0' do
    @item.price = 0.00
    expect(@item).to_not be_valid
  end

  describe '.items in menu' do
    it 'returns items which are not retired' do
      item = create(:item, :retired, title: 'Tasty fish')
      items = Item.items_in_menu
      expect(items.member?(item)).to eq(false)
    end
  end
end
