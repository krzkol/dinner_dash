require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:invalid_attributes) {
    { email: nil, first_name: nil, last_name: nil, password: nil,
      password_confirmation: nil }
  }

  let(:valid_session) { {} }

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new, {}, valid_session
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe 'POST # create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, { user: attributes_for(:user) }, valid_session
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: attributes_for(:user) }, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to_not be_a_new_record
      end

      it 'redirects to home page with success message' do
        post :create, { user: attributes_for(:user) }, valid_session
        expect(flash[:success]).to be
        expect(response).to redirect_to(root_path)
      end

      it 'cannot create an admin account' do
        post :create, { user: { first_name: 'John', last_name: 'Smith', email: 'john@smith.com', password: 'pass2word', admin: true }}
        expect(assigns(:user)).not_to be_admin
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created user as @user' do
        post :create, { user: invalid_attributes }, valid_session
        expect(assigns(:user)).to be_a_new(User)
      end

      it 're-renders the form' do
        post :create, { user: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end
end
