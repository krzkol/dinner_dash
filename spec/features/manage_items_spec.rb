require 'rails_helper'

RSpec.describe 'manage items', type: :feature do
  describe 'as authenticated admin user' do
    before(:each) do
      admin = create(:user, :admin)
      visit login_path
      fill_in('Email', with: admin.email)
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

      it 'i can update item' do
        create(:item)
        visit edit_item_path(Item.last.id)
        fill_in('Title', with: 'Chopped pork')
        click_button('Update Item')
        expect(page).to have_content('Successfully updated item!')
        expect(page).to have_content('Chopped pork')
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

      it 'cannot update an item' do
        create(:item)
        visit edit_item_path(Item.last.id)
        fill_in('Price', with: 'cheap')
        click_button('Update Item')
        expect(page).to have_content('Could not update item')
        expect(page).to_not have_content('cheap')
      end
    end
  end

  describe 'as unauthenticated user' do
    it 'i cannot access new item page' do
      visit new_item_path
      expect(page).to have_content('You must be logged in')
    end

    it 'i cannot access edit page' do
      item = create(:item)
      visit edit_item_path(item.id)
      expect(page).to have_content('You must be logged in')
    end
  end

  describe 'as authenticated non-admin user' do
    before(:each) do
      user = create(:user)
      visit login_path
      fill_in('Email', with: user.email)
      fill_in('Password', with: 'agamotho')
      click_button('Log in')
    end

    it 'i cannot access new item page' do
      visit new_item_path
      expect(page).to have_content('Sorry you must be admin to access this page')
    end

    it 'i cannot access edit page' do
      item = create(:item)
      visit edit_item_path(item.id)
      expect(page).to have_content('Sorry you must be admin to access this page')
    end
  end
end
