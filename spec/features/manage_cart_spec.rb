require 'rails_helper'

describe 'cart management', type: :feature do
  describe 'as unauthenticated user i can' do
    before(:each) do
      @item = create(:item)
      visit items_path
      find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
    end

    it 'add an item to my cart' do
      expect(page).to have_content("Added #{@item.title} to cart")
    end

    it 'view my cart' do
      expect(page).to have_content('Your Cart')
      within '.panel' do
        expect(page).to have_content(@item.title)
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
      find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
      expect(page).to have_field('order_item[quantity]', with: 2)
      expect(page).to have_content("x #{@item.title}")
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
