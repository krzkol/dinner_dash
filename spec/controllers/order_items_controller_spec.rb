require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:item) { Item.create(title: 'omelete with bacon', description: 'tasty omelete', price: 3.60) }
  let(:valid_session) { {} }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new cart' do
        expect {
          post :create, { item_id: item.id } , valid_session
        }.to change(Cart, :count).by(1)
        expect(assigns(:cart)).to be_a(Cart)
        expect(assigns(:cart)).to be_persisted
      end

      it 'creates a new order_item' do
        expect {
          post :create, { item_id: item.id }, valid_session
        }.to change(OrderItem, :count).by(1)
        expect(assigns(:order_item)).to be_a(OrderItem)
      end

      it 'adds order_item to a cart' do
        post :create, { item_id: item.id } , valid_session
        expect(assigns(:cart).order_items.count).to be(1)
        expect(assigns(:cart).order_items).to eq([assigns(:order_item)])
      end

      it 'redirects to root_page with success message' do
        post :create, { item_id: item.id } , valid_session
        expect(flash[:success]).to be
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'not create a new order_item' do
        expect {
          post :create, { item_id: nil }, valid_session
        }.not_to change(OrderItem, :count)
        expect(assigns(:order_item)).to be(nil)
      end

      it 'not create a new cart' do
        expect {
          post :create, { item_id: nil } , valid_session
        }.not_to change(Cart, :count)
        expect(assigns(:cart)).to be(nil)
      end

      it 'redirects to root page with error message' do
        post :create, { item_id: nil }, valid_session
        expect(flash[:danger]).to be
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
