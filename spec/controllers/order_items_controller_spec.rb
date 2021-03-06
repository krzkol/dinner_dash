require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  before(:all) do
    @item = create(:item)
    @valid_session = {}
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new cart' do
        expect {
          post :create, { item_id: @item.id } , @valid_session
        }.to change(Cart, :count).by(1)
        expect(assigns(:cart)).to be_a(Cart)
        expect(assigns(:cart)).to be_persisted
      end

      it 'creates a new order_item' do
        expect {
          post :create, { item_id: @item.id }, @valid_session
        }.to change(OrderItem, :count).by(1)
        expect(assigns(:order_item)).to be_a(OrderItem)
      end

      it 'adds order_item to a cart' do
        post :create, { item_id: @item.id }, @valid_session
        expect(assigns(:cart).order_items.count).to eq(1)
        expect(assigns(:cart).order_items).to eq([assigns(:order_item)])
      end

      it 'increase quantity of item' do
        post :create, { item_id: @item.id }, @valid_session
        post :create, { item_id: @item.id }, @valid_session
        expect(assigns(:cart).order_items.count).to eq(1)
        expect(assigns(:cart).order_items.first.quantity).to eq(2)
      end

      it 'redirects to root_page with success message' do
        post :create, { item_id: @item.id }, @valid_session
        expect(flash[:success]).to be
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'not create a new order_item' do
        expect {
          post :create, { item_id: nil }, @valid_session
        }.not_to change(OrderItem, :count)
        expect(assigns(:order_item)).to be(nil)
      end

      it 'not create a new cart' do
        expect {
          post :create, { item_id: nil } , @valid_session
        }.not_to change(Cart, :count)
        expect(assigns(:cart)).to be(nil)
      end

      it 'redirects to root page with error message' do
        post :create, { item_id: nil }, @valid_session
        expect(flash[:danger]).to be
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid_params' do

      before(:all) do
        @cart = Cart.create
        @valid_attributes = { price: @item.price, item_id: @item.id, item_group: @cart }
        @new_attributes = { quantity: 2 }
        @order_item = OrderItem.create! @valid_attributes
      end

      before(:each) do
        put :update, { id: @order_item.to_param, order_item: @new_attributes }, @valid_session
      end

      it 'updates quantity of item' do
        @order_item.reload
        expect(@order_item.quantity).to eq(2)
      end

      it 'assigns the requested order_item as @order_item' do
        expect(assigns(:order_item)).to eq(@order_item)
      end

      it 'redirects to root_page with success message' do
        expect(flash[:success]).to be
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    before(:all) do
      @cart = Cart.create
      @valid_attributes = { price: @item.price, item_id: @item.id, item_group: @cart }
      @order_item = OrderItem.create! @valid_attributes
    end

    it 'destroys the requested order_item' do
      expect {
        delete :destroy, { id: @order_item.to_param }, @valid_session
      }.to change(OrderItem, :count).by(-1)
      expect(flash[:success]).to be
    end
  end
end
