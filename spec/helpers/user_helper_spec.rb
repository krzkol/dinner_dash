require 'rails_helper'

describe UserHelper do
  describe '#current_user' do
    it 'return nil for logged out user' do
      session[:user_id] = nil
      expect(helper.current_user).to be(nil)
    end

    it 'return User object for logged in user' do
      user = User.create(email: 'sample@mail.com', first_name: 'Jonathan', last_name: 'Kent', password: 'superman',
                         password_confirmation: 'superman')
      session[:user_id] = user.id
      expect(helper.current_user).to be_a(User)
      expect(helper.current_user).to eq(user)
    end
  end
end
