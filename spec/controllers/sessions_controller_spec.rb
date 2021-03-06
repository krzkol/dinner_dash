require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:invalid_attributes) {
    { email: nil, password: nil }
  }

  let(:valid_session) { {} }

  describe 'POST #create' do

    context 'with valid attributes' do
      it 'log in user' do
        user = User.create! attributes_for(:user)
        post :create, { email: user.email, password: user.password }, valid_session
        expect(flash[:success]).to be
      end
    end

    context 'with invalid attributes' do
      it 'render form with error message' do
        post :create, invalid_attributes, valid_session
        expect(flash[:danger]).to be
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'logs out user' do
      user = User.create! attributes_for(:user)
      post :create, { email: user.email, password: user.password }, valid_session
      delete :destroy, { id: user.id }, valid_session
      expect(flash[:success]).to be
    end
  end
end
