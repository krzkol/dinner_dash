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

      before do
        User.create(email: 'foo@bar.com', first_name: 'Fooler', last_name: 'Barcode',
                    password: 'pass2word', password_confirmation: 'pass2word')
      end

      it 'successfully log in' do
        visit root_path
        click_link('Sign in')
        fill_in('Email', with: 'foo@bar.com')
        fill_in('Password', with: 'pass2word')
        click_button('Log in')
        expect(page).to have_content('Successfully logged in')
      end

      it 'log out' do
        visit root_path
        click_link('Sign in')
        fill_in('Email', with: 'foo@bar.com')
        fill_in('Password', with: 'pass2word')
        click_button('Log in')
        click_link('Log out')
        expect(page).to have_content('Successfully logged out')
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

      it 'not log in' do
        visit root_path
        click_link('Sign in')
        fill_in('Email', with: '')
        fill_in('Password', with: '')
        click_button('Log in')
        expect(page).to have_content('Could not log in')
      end
    end
  end
end
