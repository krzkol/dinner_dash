require 'rails_helper'

describe 'cart management', type: :feature do
  describe 'as unauthenticated user i can' do
    let(:item_data) { { title: 'fish with chips', description: 'fresh fish with tasty chips', price: 4.50 } }

    it 'add an item to my cart' do
      item = Item.create! item_data
      visit items_path
      first(:link, 'Add to cart').click
      expect(page).to have_content('Added fish with chips to cart')
    end
  end
end
