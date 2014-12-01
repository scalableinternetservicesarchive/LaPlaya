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

  it 'is invalid with a provider but no uid' do
    expect(FactoryGirl.build(:user, provider: 'facebook')).to_not be_valid
  end

  it 'is invalid with a provider but no uid' do
    expect(FactoryGirl.build(:user, uid: '12344321')).to_not be_valid
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

  describe 'creating a user from omniauth' do
    before do
      @stub_auth = OmniAuth::AuthHash.new({
                                              :provider => 'facebook',
                                              :uid => '12344321',
                                              :info => {email: 'test@test.com'}
                                          })
    end
    subject { @user }

    describe 'without passing in any params' do
      before do
        @user = User.from_omniauth(@stub_auth)
      end
      it { should_not be_valid }

      its(:username) { should be_nil }

      it 'should have its attributes set from the auth hash' do
        expect(@user.email).to eq 'test@test.com'
        expect(@user.provider).to eq 'facebook'
        expect(@user.uid).to eq '12344321'
      end

      it 'should have a randomly generated password' do
        expect(@user.password).to be_present
      end

    end

    describe 'when passing in params' do
      before do
        @user = User.from_omniauth(@stub_auth,
                                   {
                                       username: 'helloworld',
                                       email: 'helloworld@test.com',
                                       password: 'thisisatest'
                                   }
        )
      end
      it { should be_valid }
      it { should be_persisted }

      it 'should have its unique attributes set from the auth hash' do
        expect(@user.provider).to eq 'facebook'
        expect(@user.uid).to eq '12344321'
      end

      it 'should have its unique attributes set from the params' do
        expect(@user.username).to eq 'helloworld'
      end

      it 'should have any duplicate attributes set from the params' do
        expect(@user.email).to eq 'helloworld@test.com'
        expect(@user.password).to eq 'thisisatest'
      end

    end
    describe 'when the user already exists' do
      before do
        @existing_user = FactoryGirl.create(:user, provider: @stub_auth.provider, uid: @stub_auth.uid, email: 'nonoauthemail@test.com', username: 'existingusername')
        @user = User.from_omniauth(@stub_auth,
                                   {
                                       username: 'helloworld',
                                       email: 'helloworld@test.com',
                                       password: 'thisisatest'
                                   }
        )
      end
      it 'should fetch the existing record' do
        expect(@user).to eq @existing_user
      end
      it 'should not alter the attributes of the existing user' do
        expect(@user.attributes).to eq @existing_user.attributes
        expect(@user.email).to eq 'nonoauthemail@test.com'
        expect(@user.username).to eq 'existingusername'
      end
    end
  end

  describe 'building a new user from the session' do

    subject { @user }

    describe 'when nothing is in the session' do
      before do
        attributes = FactoryGirl.build_stubbed(:user).attributes
        @attributes = attributes.slice('username', 'email').merge('password' => Faker::Internet.password)
        @user = User.new_with_session(@attributes)
      end

      it { should be_valid }
      it { should_not be_persisted }

      it 'should have the attributes from the hash' do
        expect(@user.email).to eq @attributes['email']
        expect(@user.username).to eq @attributes['username']
        expect(@user.password).to eq @attributes['password']
      end
    end

    describe 'when the session has devise data without a password' do
      before do
        attributes = FactoryGirl.build_stubbed(:user).attributes
        @attributes = attributes.slice('username', 'email')
        @session = {
            'devise.user_attributes' => {
                email: 'helloworld@test.com'
            }
        }
        @user = User.new_with_session(@attributes, @session)
      end

      it { should be_valid }
      it { should_not be_persisted }

      it 'should have been generated a password' do
        expect(@user.password).to be_present
        expect(@user.password.length).to be
      end

      it 'should have its unique attributes set from the params' do
        expect(@user.username).to eq @attributes['username']
      end

      it 'should have any duplicate attributes set from the params' do
        expect(@user.email).to eq @attributes['email']
      end

    end
    describe 'when the session has devise data' do
      before do
        attributes = FactoryGirl.build_stubbed(:user).attributes
        @attributes = attributes.slice('username', 'email')
        @session = {
            'devise.user_attributes' => {
                email: 'helloworld@test.com',
                password: 'thisisatest',
                password_confirmation: 'thisisatest'
            }
        }
        @user = User.new_with_session(@attributes, @session)
      end

      it { should be_valid }
      it { should_not be_persisted }

      it 'should have its unique attributes set from the session' do
        expect(@user.password).to eq 'thisisatest'
        expect(@user.password_confirmation).to eq 'thisisatest'
      end

      it 'should have its unique attributes set from the params' do
        expect(@user.username).to eq @attributes['username']
      end

      it 'should have any duplicate attributes set from the params' do
        expect(@user.email).to eq @attributes['email']
      end

    end

  end

  describe '#username_is_valid?' do
    subject { @response }
    describe 'when the username is valid' do
      before do
        @response = User.username_is_valid?(FactoryGirl.build_stubbed(:user).username)
      end
      it 'should return a hash with valid set to true' do
        expect(@response).to eq ({valid: true})
      end
    end

    describe 'when the username is too short' do
      before do
        @response = User.username_is_valid?('a')
      end
      it 'should return a hash with valid set to false' do
        expect(@response[:valid]).to eq false
      end
      it 'should return a hash with error messages' do
        expect(@response[:message]).to be_present
      end
    end

    describe 'when the username is taken' do
      before do
        user = FactoryGirl.create(:user)
        @response = User.username_is_valid?(user.username)
      end
      it 'should return a hash with valid set to false' do
        expect(@response[:valid]).to eq false
      end
      it 'should return a hash with error messages' do
        expect(@response[:message]).to be_present
      end
    end
  end

  describe '#email_is_valid?' do
    subject { @response }
    describe 'when the email is valid' do
      before do
        @response = User.email_is_valid?(FactoryGirl.build_stubbed(:user).email)
      end
      it 'should return a hash with valid set to true' do
        expect(@response).to eq ({valid: true})
      end
    end

    describe 'when the email is invalid' do
      before do
        @response = User.email_is_valid?('a@a')
      end
      it 'should return a hash with valid set to false' do
        expect(@response[:valid]).to eq false
      end
      it 'should return a hash with error messages' do
        expect(@response[:message]).to be_present
      end
    end

    describe 'when the email is taken' do
      before do
        user = FactoryGirl.create(:user)
        @response = User.email_is_valid?(user.email)
      end
      it 'should return a hash with valid set to false' do
        expect(@response[:valid]).to eq false
      end
      it 'should return a hash with error messages' do
        expect(@response[:message]).to be_present
      end
    end
  end


  describe '#password_is_valid?' do
    subject { @response }
    describe 'when the password is valid' do
      before do
        @response = User.password_is_valid?(FactoryGirl.build_stubbed(:user).password)
      end
      it 'should return a hash with valid set to true' do
        expect(@response).to eq ({valid: true})
      end
    end

    describe 'when the password is invalid' do
      before do
        @response = User.password_is_valid?('aaa')
      end
      it 'should return a hash with valid set to false' do
        expect(@response[:valid]).to eq false
      end
      it 'should return a hash with error messages' do
        expect(@response[:message]).to be_present
      end
    end
  end

end
