class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:facebook, :google_oath2]

  validates_uniqueness_of :username
  validates_presence_of :username


  def self.new_from_omniauth(auth, attrs = {})
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.assign_attributes attrs
    end
  end

  def self.create_from_omniauth(auth, attrs = {})
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.assign_attributes attrs
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session['devise.auth_method'].starts_with?('devise.omniauth')
        auth_method = session['devise.auth_method']
        data = session[auth_method]
        user.provider = data['provider']
        user.uid = data['uid']
        case(auth_method)
          when 'devise.omniauth.facebook_data'
            if data && data['extra']['raw_info']
              user.email = data['extra']['raw_info']['email'] if user.email.blank?
            end
            user.password = Devise.friendly_token[0,20] if user.password.blank?
          else
            # type code here
        end
      end
    end
  end

  def self.username_is_valid?(username)
    errors = User.new(username: username)
    errors.valid?
    errors = errors.errors.full_messages_for(:username)
    response = {}
    if errors.empty?
      response[:valid] = true
    else
      response[:valid] = false
      response[:message] = errors
    end
    response
  end

  def self.email_is_valid?(email)
    errors = User.new(email: email)
    errors.valid?
    errors = errors.errors.full_messages_for(:email)
    response = {}
    if errors.empty?
      response[:valid] = true
    else
      response[:valid] = false
      response[:message] = errors
    end
    response
  end

  def self.password_is_valid?(password)
    errors = User.new(password: password)
    errors.valid?
    errors = errors.errors.full_messages_for(:password)
    response = {}
    if errors.empty?
      response[:valid] = true
    else
      response[:valid] = false
      response[:message] = errors
    end
    response
  end

end
