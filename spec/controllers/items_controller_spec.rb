require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:valid_attributes) do
    { title: 'omelete with chips', description: 'tasty omelete with salted chips', price: 8.50 }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all items as @items' do
      item = Item.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:items)).to eq([item])
    end
  end
end
