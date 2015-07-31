require 'rails_helper'

describe 'browse items', type: :feature do
  describe 'as unauthenticated user i can' do
    let!(:category) { create(:category) }
    let!(:item) { create(:item) }

    it 'browse all items' do
      visit items_path
      expect(page).to have_content('cheese')
    end

    it 'browse items by category' do
      category.items << item
      visit category_path(category)
      expect(page).to have_content('burger')
    end
  end

  describe 'as authenticated user' do
    before(:each) do
      create(:user)
      visit login_path
      fill_in('Email', with: 'doctor@strange.com')
      fill_in('Password', with: 'agamotho')
      click_button('Log in')
    end

    it 'i can add item to cart on item page' do
      Item.create! attributes_for(:item)
      visit items_path
      first(:link, 'Cheeseburger').click
      click_link('Add to cart')
      expect(page).to have_content('Added Cheeseburger')
    end

    it 'i cannot add retired item to the cart' do
      create(:item, :retired, title: 'Fish')
      visit items_path
      first(:link, 'Fish').click
      expect(page).to_not have_link('Add to cart')
    end
  end
end
