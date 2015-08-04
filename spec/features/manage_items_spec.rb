require 'rails_helper'

RSpec.describe 'manage items', type: :feature do
  describe 'as authenticated admin user' do
    before(:each) do
      create(:user, :admin)
      visit login_path
      fill_in('Email', with: 'doctor@strange.com')
      fill_in('Password', with: 'agamotho')
      click_button('Log in')
    end

    describe 'with valid data' do
      it 'i can create a new item' do
        visit new_item_path
        fill_in('Title', with: 'Baked chicken')
        fill_in('Description', with: 'Delicious chicken baked for 20 minutes.')
        fill_in('Price', with: 11.50)
        click_button('Create Item')
        expect(page).to have_content('Successfully created item!')
      end
    end

    describe 'with invalid data' do
      it 'i cannot create a new item' do
        item = create(:item)
        visit new_item_path
        fill_in('Title', with: item.title)
        fill_in('Description', with: 'AA')
        fill_in('Price', with: "")
        click_button('Create Item')
        expect(page).to have_content('Could not create an item')
      end
    end
  end
end
