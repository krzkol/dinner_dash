require 'rails_helper'

describe 'manage categories' do
  describe 'as unauthenticated user' do
    it 'i cannot access new category page' do
      visit new_category_path
      expect(page).to have_content('You must be logged in')
    end
  end

  describe 'as authenticated non-admin user' do
    before(:each) do
      user = create(:user)
      visit login_path
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_button('Log in')
    end

    it 'i cannot access new category page' do
      visit new_category_path
      expect(page).to have_content('Sorry you must be admin to access this page')
    end
  end

  describe 'as authenticated admin user' do
    before(:each) do
      admin = create(:user, :admin)
      visit login_path
      fill_in('Email', with: admin.email)
      fill_in('Password', with: admin.password)
      click_button('Log in')
    end

    context 'with valid params' do
      it 'i can create category' do
        visit new_category_path
        fill_in('Name', with: 'Drinks')
        click_button('Create Category')
        expect(page).to have_content('Successfully created category')
        expect(page).to have_content('Drinks')
      end
    end

    context 'with invalid params' do
      it 'i cannot create a new category' do
        visit new_category_path
        fill_in('Name', with: '')
        click_button('Create Category')
        expect(page).to have_content('Could not create a category')
      end
    end
  end
end
