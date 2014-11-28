class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  js false

  def facebook
    helper('Facebook')
  end

  def google
    helper('Google')
  end

  def helper(kind)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => kind) if is_navigational_format?
      @after_sign_in_url = after_sign_in_path_for(@user)
      render 'callback_signin', layout: false
    else
      session['devise.user_attributes'] = @user.attributes
      render 'callback_success', layout: false
    end
  end

  protected
  def after_omniauth_failure_path_for(resource_name)
    root_path
  end
end