require 'rails_helper'

describe UserHelper do
  describe '#current_user' do
    it 'return nil for logged out user' do
      session[:user_id] = nil
      expect(helper.current_user).to be(nil)
    end

    it 'return User object for logged in user' do
      user = create(:user)
      session[:user_id] = user.id
      expect(helper.current_user).to be_a(User)
      expect(helper.current_user).to eq(user)
    end
  end

  describe '#user_logged_in' do
    it 'return true for logged in user' do
      user = create(:user)
      session[:user_id] = user.id
      expect(helper.user_logged_in?).to be(true)
    end

    it 'return false for not logged user' do
      session[:user_id] = nil
      expect(helper.user_logged_in?).to be(false)
    end
  end
end
