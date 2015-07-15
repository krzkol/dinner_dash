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
end
