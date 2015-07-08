require 'rails_helper'

RSpec.describe 'manage an account', type: :feature do
  describe 'as unauthenticated user i can' do
    context 'with valid data' do
      it 'make a new account' do
        visit root_path
        click_link('Sign up')
        fill_in('Email', with: 'user@example.com')
        fill_in('First name', with: 'John')
        fill_in('Last name', with: 'Kowalski')
        fill_in('Password', with: 'secure@2')
        fill_in('Password confirmation', with: 'secure@2')
        click_button('Create User')
        expect(page).to have_content('Account successfully created')
      end
    end

    context 'with invalid data' do
      it 'not make a new account' do
        visit root_path
        click_link('Sign up')
        click_button('Create User')
        expect(page).to have_content('errors')
        expect(page).to have_content('Could not create an account')
      end
    end
  end
end
