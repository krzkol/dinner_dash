require 'rails_helper'

describe 'browse orders' do
  describe 'as unauthenticated user' do
  end

  describe 'as authenticated user' do
    before(:each) do
      user = create(:user)
      visit root_path
      click_link('Sign in')
      fill_in('Email', with: user.email)
      fill_in('Password', with: 'agamotho')
      click_button('Log in')
      @item = create(:item)
      visit items_path
      find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
      find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
      find(:xpath, "//a[@href='/order_items?item_id=#{@item.id}']").click
      visit root_path
    end

    it 'i can view list of my orders' do
      click_link('Checkout')
      click_link('Create order')
      click_link('Orders')
      expect(page).to have_content('Your orders')
    end

    it 'i can view order page' do
      click_link('Checkout')
      click_link('Create order')
      click_link('Orders')
      click_link('Show')
      expect(page).to have_content('Your order')
      expect(page).to have_content(@item.title)
      expect(page).to have_content(2.50)
      expect(page).to have_content(3)
      expect(page).to have_content(7.50)
      expect(page).to have_link(@item.title)
      expect(page).to have_content('Ordered')
      expect(page).to have_content('Total')
      expect(page).to have_content('Ordered:')
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

    it 'i can browse all orders' do
      order = create(:order)
      visit orders_path
      expect(page).to have_content(order.total)
    end

    it 'i can see count of specific order type orders' do
      create(:order)
      create(:order, :paid)
      create(:order, :completed)
      create(:order, :cancelled)
      visit orders_path
      expect(page).to have_content(Order.count)
      expect(page).to have_content(Order.where(status: 'ordered').count)
      expect(page).to have_content(Order.where(status: 'paid').count)
      expect(page).to have_content(Order.where(status: 'cancelled').count)
      expect(page).to have_content(Order.where(status: 'completed').count)
    end

    it 'i can access order page' do
      order = create(:order)
      visit orders_path
      first(:link, 'Show').click
      expect(page).to have_content(order.total)
    end

    it 'i can view order details' do
      order = create(:order).decorate
      visit orders_path
      find(:xpath, "//a[@href='/orders/#{order.id}']").click
      expect(page).to have_content(order.created_at)
      expect(page).to have_content(order.user.full_name)
      expect(page).to have_content(order.user.email)
      oi = order.order_items.first
      expect(page).to have_link(oi.item.title)
      expect(page).to have_content(oi.quantity)
      expect(page).to have_content(oi.price)
      expect(page).to have_content(oi.total)
      expect(page).to have_content(order.total)
      expect(page).to have_content(order.status.capitalize)
    end

    it 'i can browse specific order types' do
      order = create(:order, :paid)
      visit orders_path
      click_link('Completed')
      expect(page).to_not have_content(order.total)
    end
  end
end
