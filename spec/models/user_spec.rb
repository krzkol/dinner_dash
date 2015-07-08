require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(first_name: 'Martin', last_name: 'Luther', email: 'martin@luther.com',
                        password: 'password') }
  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is not valid without a first_name' do
    user.first_name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid with too short first_name' do
    user.first_name = 'aa'
    expect(user).to_not be_valid
  end

  it 'is not valid with too long first_name' do
    user.first_name = 'a' * 26
    expect(user).to_not be_valid
  end

  it 'is not valid without a last_name' do
    user.last_name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid with too short last_name' do
    user.last_name = 'aa'
    expect(user).to_not be_valid
  end

  it 'is not valid with too long last_name' do
    user.first_name = 'a' * 36
    expect(user).to_not be_valid
  end

  it 'is not valid without a full_name' do
    user.first_name = nil
    user.last_name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without an email address' do
    user.email = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).to_not be_valid
  end

  it 'is not valid with too short password' do
    user.password = 'a' * 7
    expect(user).to_not be_valid
  end

  it 'is not valid with the same address' do
    user.save
    user_copy = User.create(email: user.email, full_name: user.full_name)
    expect(user_copy.valid?).to eq(false)
  end

  it 'is not valid with the same address uppercase' do
    user.save
    user_copy = User.create(email: user.email.upcase, full_name: user.full_name)
    expect(user_copy.valid?).to eq(false)
  end

  it 'is not valid with incorrect email address' do
    invalid_addresses = %w[foo@example,com user_at_bar.org user.name@pass.
                        word@i_am_.com man@ea+ter.de]
    invalid_addresses.each do |ia|
      user.email = ia
      expect(user).to_not be_valid
    end
  end

  it 'is valid with correct email address' do
    valid_addresses = %w[user@name.com R_TDD-DHH@rails.ruby.org admin@example.com
			first.last@user.name laura+joe@stephen.cm]
    valid_addresses.each do |va|
      user.email = va
      expect(user).to be_valid
    end
  end

  it 'display name must be at least 2 characters' do
    user.display_name = 'a'
    expect(user).to_not be_valid
  end

  it 'display name must be at most 32 characters' do
    user.display_name = 'a' * 33
    expect(user).to_not be_valid
  end
end
