require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  it 'has an array of items' do
    expect(category.items).to eq([])
  end
end
