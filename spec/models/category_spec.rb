require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { Category.new(name: 'Drinks') }

  it 'has an array of items' do
    expect(category.items).to eq([])
  end
end
