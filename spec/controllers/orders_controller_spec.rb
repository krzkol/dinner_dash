require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:valid_session) { {} }

  before do
    cart = Cart.create
    item = create(:item)
    order_item = OrderItem.create(item: item, item_group: cart, price: item.price, quantity: 1)
    cart.order_items << order_item
    session[:cart_id] = cart.id
    user = create(:user)
    session[:user_id] = user.id
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates order' do
        expect {
          post :create, {}, valid_session
        }.to change(Order, :count).by(1)
        expect(flash[:success]).to be
      end
    end

    context 'with invalid attributes' do
      it 'not create an order' do
        session[:user_id] = nil
        post :create, {}, valid_session
        expect(flash[:danger]).to be
      end
    end
  end
end
