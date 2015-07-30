require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:valid_session) { {} }

  before do
    cart = Cart.create
    item = create(:item)
    order_item = OrderItem.create(item: item, item_group: cart, price: item.price)
    cart.order_items << order_item
    session[:cart_id] = cart.id
    user = create(:user)
    session[:user_id] = user.id
  end

  describe 'GET #index' do
    context 'as logged in user' do
      it 'can access orders page' do
        get :index, {}, valid_session
        expect(response).to_not redirect_to(login_path)
      end

      it 'order page shows only my orders' do
        post :create, {}, valid_session
        cart = Cart.create
        item = create(:item)
        order_item = OrderItem.create(item: item, item_group: cart, price: item.price)
        cart.order_items << order_item
        session[:cart_id] = cart.id
        user = User.create!(first_name: 'Josh', last_name: 'True', email: 'josh@true.com', password: 'truepass')
        session[:user_id] = user.id
        post :create, {}, valid_session
        get :index, {}, valid_session
        expect(assigns(:orders).all? { |o| o.user == user }).to eq(true)
      end
    end

    context 'as logged out user' do
      it 'cannot access checkout page' do
        session[:user_id] = nil
        get :index, {}, valid_session
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #new' do
    context 'as logged in user' do
      it 'can access checkout page' do
        get :new, {}, valid_session
        expect(response).to_not redirect_to(login_path)
      end
    end

    context 'as logged out user' do
      it 'cannot access checkout page' do
        session[:user_id] = nil
        get :new, {}, valid_session
        expect(response).to redirect_to(login_path)
      end
    end
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
