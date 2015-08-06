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
      it 'i can create a new item and assign item to category' do
        category = create(:category, name: 'Chicken')
        visit new_item_path
        fill_in('Title', with: 'Baked chicken')
        fill_in('Description', with: 'Delicious chicken baked for 20 minutes.')
        fill_in('Price', with: 11.50)
        check(category.name)
        click_button('Create Item')
        expect(page).to have_content('Successfully created item!')
        visit category_path(category.id)
        expect(page).to have_content('Baked chicken')
      end

      it 'i can update item' do
        create(:item)
        visit edit_item_path(Item.last.id)
        fill_in('Title', with: 'Chopped pork')
        click_button('Update Item')
        expect(page).to have_content('Successfully updated item!')
        expect(page).to have_content('Chopped pork')
      end

      it 'i can update items categories' do
        category = create(:category, name: 'Chips')
        visit new_item_path
        fill_in('Title', with: 'Chips and salad')
        fill_in('Description', with: 'Tasty chips with fresh salad')
        fill_in('Price', with: 7.60)
        check(category.name)
        click_button('Create Item')
        category2 = Category.create(name: 'Salads')
        visit edit_item_path(Item.last.id)
        uncheck(category.name)
        check(category2.name)
        click_button('Update Item')
        visit category_path(category.id)
        expect(page).to_not have_content('Chips and salad')
        visit category_path(category2.id)
        expect(page).to have_content('Chips and salad')
      end

      it 'i can make item retired' do
        item = create(:item)
        visit edit_item_path(item.id)
        box = find('#item_retired')
        expect(box).to_not be_checked
        check('Retired')
        click_button('Update Item')
        expect(page).to have_content('Successfully updated item!')
        visit edit_item_path(item.id)
        box = find('#item_retired')
        expect(box).to be_checked
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
