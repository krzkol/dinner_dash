require 'rails_helper'

describe 'manage orders', type: :feature do
  before(:each) do
    @item = create(:item)
    visit items_path
    find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
    find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
    find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
  end

  describe 'as authenticated admin user' do
    before(:each) do
      admin = create(:user, :admin)
      visit login_path
      fill_in('Email', with: admin.email)
      fill_in('Password', with: admin.password)
      click_button('Log in')
    end

    it 'i can mark ordered order as paid' do
      order = create(:order)
      visit orders_path
      click_link('Ordered')
      click_link('Mark as paid')
      click_link('Paid')
      expect(page).to have_content(order.total)
    end

    it 'i can cancel ordered order' do
      order = create(:order)
      visit orders_path
      click_link('Ordered')
      click_link('Cancel')
      click_link('Cancelled')
      expect(page).to have_content(order.total)
    end

    it 'i can cancel paid order' do
      order = create(:order, :paid)
      visit orders_path
      click_link('Paid')
      click_link('Cancel')
      click_link('Cancelled')
      expect(page).to have_content(order.total)
    end

    it 'i can mark paid order as completed' do
      order = create(:order, :paid)
      visit orders_path
      click_link('Paid')
      click_link('Mark as completed')
      click_link('Completed')
      expect(page).to have_content(order.total)
    end
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
