require 'rails_helper'

describe 'manage orders', type: :feature do
  before(:each) do
    @item = create(:item)
    visit items_path
    find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
    find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
    find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
  end

  describe 'as authenticated user' do
    before(:each) do
      user = create(:user)
      click_link('Sign in')
      fill_in('Email', with: user.email)
      fill_in('Password', with: 'agamotho')
      click_button('Log in')
      visit root_path
    end

    it 'i can checkout' do
      click_link('Checkout')
      expect(page).to have_content('Your order')
    end

    it 'i can confirm order' do
      click_link('Checkout')
      click_link('Create order')
      expect(page).to have_content('Successfully created order')
    end

    it 'i can view list of my orders' do
      click_link('My orders')
      expect(page).to have_content('Your orders')
    end

    it 'i can view order page' do
      click_link('Checkout')
      click_link('Create order')
      click_link('My orders')
      click_link('Show')
      expect(page).to have_content('Your order')
      expect(page).to have_content(@item.title)
      expect(page).to have_content(2.50)
      expect(page).to have_content(3)
      expect(page).to have_content(7.50)
      expect(page).to have_link(@item.title)
      expect(page).to have_content('ordered')
      expect(page).to have_content('Total')
      expect(page).to have_content('Ordered:')
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

    it 'cannot view my orders' do
      visit orders_path
      expect(page).to have_content('You must be logged in')
    end

    it 'cannot view specific order' do
      visit order_path(id: 1)
      expect(page).to have_content('You must be logged in')
    end
  end
end
