require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  it 'should be valid' do
    expect(order).to be_valid
  end

  it 'should refer to user' do
    expect(order).to respond_to(:user)
  end

  it 'is not valid without user' do
    order.user = nil
    expect(order).to_not be_valid
  end

  it 'is not valid without items' do
    order.order_items = []
    expect(order).to_not be_valid
  end

  it 'is not valid with incorrect status' do
    order.status = "bought"
    expect(order).to_not be_valid
  end

  describe '#copy_items_from_cart' do
    before(:all) do
      @cart = Cart.create
      item = create(:item)
      @order_item =  OrderItem.new(item_id: item.id, price: item.price)
      @cart.order_items << @order_item
      @order = Order.new
      @order.copy_items_from_cart(@cart)
    end
    it 'copies items from cart to an order' do
      expect(@order.order_items.size).to be > 0
    end

    it 'assigns item to order' do
      expect(@order_item.item_group).to be_kind_of(Order)
    end

    it 'removes item from cart' do
      expect(@cart.order_items.member?(@order_item)).to eq(false)
    end
  end

  describe '.find_user_orders' do
    it 'returns orders for specific user' do
      user = create(:user)
      order = create(:order, user_id: user.id)
      user2 = User.create(first_name: 'Josh', last_name: 'Kowal', email: 'josh@kow.al', password: 'pass2word')
      expect(Order.find_user_orders(user2)).to eq([])
      expect(Order.find_user_orders(user).member?(order)).to eq(true)
    end
  end

  describe '#total' do
    it 'return sum of order_items subtotals' do
      item1 = build(:item)
      item2 = build(:item)
      item1.title = "Burger"
      item2.title = "Ham"
      item1.price = 2.50
      item2.price = 5.70
      order = Order.new
      order.order_items << OrderItem.new(item: item1, price: item1.price)
      order.order_items << OrderItem.new(item: item2, price: item2.price, quantity: 5)
      expect(order.total).to eq(item1.price + 5 * item2.price)
    end
  end
end
