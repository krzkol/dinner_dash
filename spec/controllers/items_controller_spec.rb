require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'assigns all items as @items' do
      item = Item.create! attributes_for(:item)
      get :index, {}, valid_session
      expect(assigns(:items)).to eq([item])
    end
  end
end
