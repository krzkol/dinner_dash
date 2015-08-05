require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  it 'is valid' do
    expect(category).to be_valid
  end

  it 'has an array of items' do
    expect(category.items).to eq([])
  end

  it 'is not valid without name' do
    category.name = nil
    expect(category).to_not be_valid
  end 
end
