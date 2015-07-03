require 'rails_helper'

describe 'browse items', type: :feature do
  describe 'as unauthenticated user i can' do
    let(:category) { Category.create(name: 'Drinks') }
    let(:valid_item) { { title: 'onion chips', description: 'chips from onion', price: 2.50, category_ids: [category.id] } }

    it 'browse all items' do
      Item.create! valid_item
      Item.create(title: 'sausage', description: 'delicious sausage', price: 4.50)
      visit items_path
      expect(page).to have_content('chips')
      expect(page).to have_content('sausage')
    end

    it 'browse items by category' do
      item = Item.create! valid_item
      visit category_path(category)
      expect(page).to have_content('onion')
    end
  end
end
