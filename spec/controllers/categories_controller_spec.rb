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
end
