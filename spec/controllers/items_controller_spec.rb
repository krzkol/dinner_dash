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

  describe "GET #new" do
    it "assigns a new item as @item" do
      get :new, {}, valid_session
      expect(assigns(:item)).to be_a_new(Item)
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
end
