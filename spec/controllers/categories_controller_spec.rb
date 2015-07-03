require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:valid_attributes) {
    { name: 'Tasty meat' }
  }

  let(:valid_session) { {} }

  describe 'GET #show' do
    it 'assigns the requested category as @category' do
      category = Category.create! valid_attributes
      get :show, { id: category.to_param }, valid_session
      expect(assigns(:category)).to eq(category)
    end
  end
end
