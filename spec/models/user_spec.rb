require 'rails_helper'

RSpec.describe User, :type => :model do

  it 'has a valid factory' do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  it 'is invalid without a username' do
    expect(FactoryGirl.build(:user, username: nil)).to_not be_valid
  end

  it 'is invalid with a short username' do
    expect(FactoryGirl.build(:user, username: 'a'*3)).to_not be_valid
  end

  it 'is invalid with a long username' do
    expect(FactoryGirl.build(:user, username: 'a'*27)).to_not be_valid
  end

  it 'is invalid without a email' do
    expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
  end

  it 'is invalid with an invalid a email' do
    expect(FactoryGirl.build(:user, email: 'test@bar')).to_not be_valid
  end

  it 'is invalid without a password' do
    expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  end

  it 'is invalid with a short password' do
    expect(FactoryGirl.build(:user, password: 'a'*7)).to_not be_valid
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
    it { should respond_to(:liked_projects) }
    it { should respond_to(:projects) }

    describe 'another user with the same username' do
      before do
        @second_user = FactoryGirl.build(:user, username: @user.username)
      end
      subject { @second_user }
      it { should_not be_valid }
    end

    describe 'another user with the same email' do
      before do
        @second_user = FactoryGirl.build(:user, email: @user.email)
      end
      subject { @second_user }
      it { should_not be_valid }
    end


  end

end
