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
        expect(page).to have_content('Fish')
      end
    end

    it 'delete from cart' do
      expect(page).to have_link('Delete')
      first(:link, 'Delete').click
      expect(page).to_not have_link('Delete')
    end

    it 'not view cart if has no items within' do
      expect(page).to have_link('Delete')
      first(:link, 'Delete').click
      expect(page).to_not have_content('Your Cart')
    end

    it 'increase quantity of item by adding it twice' do
      first(:link, 'Add to cart').click
      expect(page).to have_field('order_item[quantity]', with: 2)
      expect(page).to have_content('x Fish')
    end

    it 'change quantity of item with form' do
      expect(page).to have_field('order_item[quantity]', with: 1)
      page.fill_in('order_item[quantity]', with: 2)
      expect(page).to have_button('Update')
      click_button('Update')
      visit items_path
      expect(page).to have_field('order_item[quantity]', with: 2)
    end
  end
end
