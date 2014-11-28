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
  validates_length_of :username, minimum: 4, maximum: 26

  validates_presence_of :provider, if: 'uid.present?'
  validates_presence_of :uid, if: 'provider.present?'

  #Project Likes
  has_many :project_likes, dependent: :destroy
  has_many :liked_projects, through: :project_likes, source: :project

  has_many :projects

  def self.from_omniauth(auth, params = {})
    raise ArgumentError, 'auth must have provider and uid' unless auth.provider.present? && auth.uid.present?
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.assign_attributes params
    end
  end

  def self.new_with_session(params, session = {})
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.password ||= Devise.friendly_token[0,20]
        user.attributes = params
        user.valid?
      end
    else
      new(params)
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
