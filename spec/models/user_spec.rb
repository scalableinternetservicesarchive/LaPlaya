require 'rails_helper'

RSpec.describe User, :type => :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'is invalid without a username' do
    expect(FactoryGirl.build(:user, username: nil)).to_not be_valid
  end

  it 'is invalid without a email' do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it 'is invalid without a password' do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  it 'is invalid when the password and confirmation differ' do
    expect(FactoryGirl.build(:user, password: 'helloworld', password_confirmation: '')).to_not be_valid
  end

  it 'is invalid when the password is too short' do
    expect(FactoryGirl.build(:user, password: 'test')).to_not be_valid
  end

  describe 'basic user' do
    before do
      @user = FactoryGirl.create(:user)
    end
    subject { @user }

    it { should respond_to(:username) }
    it { should respond_to(:email) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:encrypted_password) }
    it { should respond_to(:provider) }
    it { should respond_to(:uid) }
    it { should respond_to(:super_admin?) }

  end

end
