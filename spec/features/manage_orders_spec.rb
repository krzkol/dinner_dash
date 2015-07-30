require 'rails_helper'

describe 'manage orders', type: :feature do
  before(:each) do
      Item.create! attributes_for(:item)
      visit items_path
      first(:link, 'Add to cart').click
  end

  describe 'as authenticated user' do
    it 'i can checkout' do
      create(:user)
      click_link('Sign in')
      fill_in('Email', with: 'doctor@strange.com')
      fill_in('Password', with: 'agamotho')
      click_button('Log in')
      visit root_path
      click_link('Checkout')
      expect(page).to have_content('Your order')
    end

    it 'i can confirm order' do
      create(:user)
      click_link('Sign in')
      fill_in('Email', with: 'doctor@strange.com')
      fill_in('Password', with: 'agamotho')
      click_button('Log in')
      visit root_path
      click_link('Checkout')
      click_link('Create order')
      expect(page).to have_content('Successfully created order')
    end
  end

  describe 'as unauthenticated user' do
    it 'cannot checkout' do
      expect(page).to_not have_link('Checkout')
    end

    it 'cannot access checkout page' do
      visit new_order_path
      expect(page).to have_content('You must be logged in')
    end
  end
end
