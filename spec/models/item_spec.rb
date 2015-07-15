require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { build(:item) }

  it 'has an array of categories' do
    expect(item.categories).to eq([])
  end
end
