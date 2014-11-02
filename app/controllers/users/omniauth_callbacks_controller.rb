class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    helper('Facebook', 'devise.facebook_data')
  end

  def google
    helper('Google', 'devise.google_data')
  end

  def helper(kind, session_key)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => kind) if is_navigational_format?
      @after_sign_in_url = after_sign_in_path_for(@user)
      render 'callback', layout: false
    else
      session[session_key] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end