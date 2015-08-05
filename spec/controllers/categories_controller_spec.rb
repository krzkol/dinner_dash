require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_session) { {} }

  describe 'GET #show' do
    it 'assigns the requested category as @category' do
      category = Category.create! attributes_for(:category)
      get :show, { id: category.to_param }, valid_session
      expect(assigns(:category)).to eq(category)
    end
  end

  before(:each) do
    user = create(:user, :admin)
    session[:user_id] = user.id
  end

  describe 'GET #new' do
    it "assigns a new category as @category" do
      get :new, {}, valid_session
      expect(assigns(:category)).to be_a_new(Category)
    end

    it 'redirects unauthenticated users with error message' do
      session[:user_id] = nil
      get :new, {}, valid_session
      expect(flash[:danger]).to be
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

  describe 'POST #create' do
    context 'with valid params' do
      it "creates a new Category" do
        expect {
          post :create, { category: attributes_for(:category) }, valid_session
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, { category: attributes_for(:category) }, valid_session
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, { category: attributes_for(:category)}, valid_session
        expect(response).to redirect_to(category_path(assigns(:category)))
      end

      it 'redirects unauthenticated users with error message' do
        session[:user_id] = nil
        post :create, { category: attributes_for(:category)}, valid_session
        expect(flash[:danger]).to be
        expect(response).to redirect_to(login_path)
      end

      it 'redirects signed in non-admin users with error message' do
        user = create(:user)
        session[:user_id] = user.id
        post :create, { category: attributes_for(:category)}, valid_session
        expect(flash[:danger]).to be
        expect(response).to redirect_to(items_path)
      end
    end

    context 'with invalid params' do
      it "re-renders the 'new' template" do
        post :create, { category: { name: nil } }, valid_session
        expect(response).to render_template("new")
      end

      it 'display error message' do
        post :create, { category: { name: nil } }, valid_session
        expect(flash[:danger]).to be
      end
    end
  end
end
