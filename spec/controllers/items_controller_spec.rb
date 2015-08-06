require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all items as @items' do
      item = Item.create! attributes_for(:item)
      get :index, {}, valid_session
      expect(assigns(:items).member?(item)).to eq(true)
    end
  end

  before(:each) do
    user = create(:user, :admin)
    session[:user_id] = user.id
  end

  describe "GET #new" do
    it "assigns a new item as @item" do
      get :new, {}, valid_session
      expect(assigns(:item)).to be_a_new(Item)
    end

    it 'redirects not signed in users' do
      session[:user_id] = nil
      get :new, {}, valid_session
      expect(response).to redirect_to(login_path)
    end

    it 'redirects signed in non-admin users with error message' do
      user = create(:user)
      session[:user_id] = user.id
      get :new, {}, valid_session
      expect(flash[:danger]).to be
      expect(response).to redirect_to(items_path)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {:item => attributes_for(:item)}, valid_session
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {:item => attributes_for(:item)}, valid_session
        expect(assigns(:item)).to be_a(Item)
        expect(assigns(:item)).to be_persisted
      end

      it "redirects to the created item" do
        post :create, {:item => attributes_for(:item)}, valid_session
        expect(response).to redirect_to(item_path(assigns(:item)))
      end

      it 'assigns selected category' do
        category = create(:category)
        post :create, { item: { title: 'Chips and salad', description: 'Tasty chips with fresh salad', price: 6.80, category_ids: [category.id]} }, valid_session
        expect(assigns(:item).categories).to eq([category])
      end

      it 'redirects not signed in users' do
        session[:user_id] = nil
        post :create, {:item => attributes_for(:item)}, valid_session
        expect(response).to redirect_to(login_path)
      end

      it 'redirects signed in non-admin users with error message' do
        user = create(:user)
        session[:user_id] = user.id
        post :create, {:item => attributes_for(:item)}, valid_session
        expect(flash[:danger]).to be
        expect(response).to redirect_to(items_path)
      end
    end

    context "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, { item: { title: nil, description: nil, price: nil } }, valid_session
        expect(response).to render_template("new")
      end

      it 'display error message' do
        post :create, { item: { title: nil, description: nil, price: nil } }, valid_session
        expect(flash[:danger]).to be
      end
    end
  end

  describe 'GET #edit' do
    it 'redirects not signed in users' do
      session[:user_id] = nil
      item = create(:item)
      get :edit, { id: item.id }, valid_session
      expect(response).to redirect_to(login_path)
    end

    it 'redirects signed in non-admin users with error message' do
      user = create(:user)
      session[:user_id] = user.id
      item = create(:item)
      get :edit, { id: item.id }, valid_session
      expect(flash[:danger]).to be
      expect(response).to redirect_to(items_path)
    end
  end

  describe 'POST #update' do
    context 'with valid params' do
      let(:new_attributes) { { title: 'Something else' } }

      it 'updates item' do
        item = create(:item)
        post :update, { id: item.id, item: new_attributes }, valid_session
        expect(flash[:success]).to be
      end

      it 'redirects to the updated item' do
        item = create(:item)
        post :update, { id: item.id, item: new_attributes }, valid_session
        expect(response).to redirect_to(item_path(item.id))
      end

      it 'assigns selected category' do
        item = create(:item)
        category = Category.create(name: 'Chips')
        post :create, { id: item.id, item: { title: 'Chips and salad', description: 'Tasty chips with fresh salad', price: 6.80, category_ids: [category.id]} }, valid_session
        expect(assigns(:item).categories).to eq([category])
      end

      it 'redirects not signed in users' do
        session[:user_id] = nil
        item = create(:item)
        post :update, { id: item.id, item: new_attributes }, valid_session
        expect(response).to redirect_to(login_path)
      end

      it 'redirects signed in non-admin users with error message' do
        user = create(:user)
        session[:user_id] = user.id
        item = create(:item)
        post :update, { id: item.id, item: new_attributes }, valid_session
        expect(flash[:danger]).to be
        expect(response).to redirect_to(items_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { { title: nil, description: nil, price: nil } }

      it 'not updates item' do
        item = create(:item)
        post :update, { id: item.id, item: invalid_attributes }, valid_session
        expect(flash[:danger]).to be
      end

      it 're-renders edit template' do
        item = create(:item)
        post :update, { id: item.id, item: invalid_attributes }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end
end
