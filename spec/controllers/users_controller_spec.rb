require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) {
    { email: 'user@ex.ample.com', first_name: 'Josh', last_name: 'Holloway',
      password: 'password', password_confirmation: 'password' }
  }

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
          post :create, { user: valid_attributes }, valid_session
        }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, { user: valid_attributes }, valid_session
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to_not be_a_new_record
      end

      it 'redirects to home page with success message' do
        post :create, { user: valid_attributes }, valid_session
        expect(flash[:success]).to be
        expect(response).to redirect_to(root_path)
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
