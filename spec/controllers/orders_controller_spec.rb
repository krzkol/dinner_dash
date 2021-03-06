require 'rails_helper'

RSpec.describe OrdersController, type: :controller do

  before do
    cart = Cart.create
    item = create(:item)
    order_item = OrderItem.create(item: item, item_group: cart, price: item.price)
    cart.order_items << order_item
    session[:cart_id] = cart.id
    user = create(:user)
    session[:user_id] = user.id
    @valid_session = {}
  end

  describe 'GET #index' do
    context 'as logged in non-admin user' do
      it 'can access orders page' do
        get :index, {}, @valid_session
        expect(response).to_not redirect_to(login_path)
      end

      it 'order page shows only my orders' do
        post :create, {}, @valid_session
        user = User.create!(first_name: 'Josh', last_name: 'True', email: 'josh@true.com', password: 'truepass')
        session[:user_id] = user.id
        post :create, {}, @valid_session
        get :index, {}, @valid_session
        expect(assigns(:orders).all? { |o| o.user == user }).to eq(true)
      end
    end

    context 'as logged in admin user' do
      before(:each) do
        admin = create(:user, :admin)
        session[:user_id] = admin.id
      end

      it 'i can browse all orders' do
        create(:order)
        get :index, {}, @valid_session
        expect(assigns(:orders)).to eq(Order.all)
      end

      it 'i can browse specific orders' do
        paid = create(:order, :paid)
        get :index, { status: 'paid' }, @valid_session
        expect(assigns(:paid).include?(paid)).to be(true)
      end

      it 'i can change ordered order to paid' do
        order = create(:order)
        put :update, { id: order.id, order: { status: 'paid'}}, @valid_session
        get :index, { status: 'paid' }, @valid_session
        expect(assigns(:paid).include?(order)).to be(true)
      end
      it 'i can cancel ordered order' do
        order = create(:order)
        put :update, { id: order.id, order: { status: 'cancelled'}}, @valid_session
        get :index, { status: 'cancelled' }, @valid_session
        expect(assigns(:cancelled).include?(order)).to be(true)
      end
      it 'i can cancel paid order' do
        order = create(:order, :paid)
        put :update, { id: order.id, order: { status: 'cancelled'}}, @valid_session
        get :index, { status: 'cancelled' }, @valid_session
        expect(assigns(:cancelled).include?(order)).to be(true)
      end
      it 'i can change paid order to completed' do
        order = create(:order, :paid)
        put :update, { id: order.id, order: { status: 'completed'}}, @valid_session
        get :index, { status: 'completed' }, @valid_session
        expect(assigns(:completed).include?(order)).to be(true)
      end
    end

    context 'as logged out user' do
      it 'cannot access checkout page' do
        session[:user_id] = nil
        get :index, {}, @valid_session
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #show' do
    it 'as order owner i can access order page' do
      post :create, {}, @valid_session
      get :show, { id: Order.last.id }, @valid_session
      expect(response).to_not redirect_to(root_path)
    end

    it 'not show order to others' do
      post :create, {}, @valid_session
      user = User.create!(first_name: 'Josh', last_name: 'True', email: 'josh@true.com', password: 'truepass')
      session[:user_id] = user.id
      get :show, { id: Order.last.id }, @valid_session
      expect(response).to redirect_to(root_path)
      expect(flash[:danger]).to be
    end
  end

  describe 'GET #new' do
    context 'as logged in user' do
      it 'can access checkout page' do
        get :new, {}, @valid_session
        expect(response).to_not redirect_to(login_path)
      end
    end

    context 'as logged out user' do
      it 'cannot access checkout page' do
        session[:user_id] = nil
        get :new, {}, @valid_session
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates order' do
        expect {
          post :create, {}, @valid_session
        }.to change(Order, :count).by(1)
        expect(flash[:success]).to be
      end
    end

    context 'with invalid attributes' do
      it 'not create an order' do
        session[:user_id] = nil
        post :create, {}, @valid_session
        expect(flash[:danger]).to be
      end
    end
  end
end
