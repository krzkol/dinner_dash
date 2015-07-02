require 'rails_helper'

describe 'browse items', type: :feature do
  describe 'as unauthenticated user i can' do
    before do
      Item.create(title: 'sausage', description: 'delicious sausage', price: 12.50)
      Item.create(title: 'chips', description: 'very tasty chips', price: 4.50)
    end

    it 'browse all items' do
      visit items_path
      expect(page).to have_content('sausage')
      expect(page).to have_content('chips')
    end
  end
end
