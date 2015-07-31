require 'rails_helper'

describe ItemDecorator do
  describe '#price' do
    it 'display price with currency and precision' do
      item = build(:item).decorate
      expect(item.price).to eq('$2.50')
    end
  end
end
