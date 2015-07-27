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
  end

  describe 'as unauthenticated user' do
    it 'cannot checkout' do
      expect(page).to_not have_link('Checkout')
    end
  end
end
