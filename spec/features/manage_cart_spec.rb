require 'rails_helper'

describe 'cart management', type: :feature do
  describe 'as unauthenticated user i can' do
    let(:item_data) { { title: 'fish with chips', description: 'fresh fish with tasty chips', price: 4.50 } }

    before(:each) do
      Item.create! item_data
      visit items_path
      first(:link, 'Add to cart').click
    end

    it 'add an item to my cart' do
      expect(page).to have_content('Added fish with chips to cart')
    end

    it 'view my cart' do
      expect(page).to have_content('Your Cart')
      within '.panel' do
        expect(page).to have_content('fish')
      end
    end

    it 'delete from cart' do
      within '.panel' do
        expect(page).to have_link('delete')
        first(:link, 'delete').click
      end
      expect(page).to_not have_link('delete')
    end
  end
end
