class Users::SessionsController < Devise::SessionsController
# before_filter :configure_sign_in_params, only: [:create]

  REMEMBER_USER_KEY = :admin_switch_user_original_user_id

# GET /resource/sign_in
# def new
#   super
# end

# POST /resource/sign_in
# def create
#   super
# end

# DELETE /resource/sign_out
  def destroy
    original_user = get_original_user
    session.delete(REMEMBER_USER_KEY)
    super
    if original_user
      flash[:notice] = 'Your original session has been restored'
      sign_in original_user
    end
  end

  def switch_user
    unless current_user && current_user.super_admin?
      head :unauthorized and return
    end
    user = User.find(params[:user_id])
    if params[:remember] == 'true'
      remember_user
    end
    sign_out :user
    sign_in user
    flash[:notice] = 'You have successfuly switched to another user'
    redirect_to (request.referrer || root_path)
  end

  protected
  def remember_user
    session[REMEMBER_USER_KEY] = current_user.id
  end

  def get_original_user
    if session[REMEMBER_USER_KEY]
      User.find_by_id(session[REMEMBER_USER_KEY])
    else
      nil
    end
  end

# You can put the params you want to permit in the empty array.
# def configure_sign_in_params
#   devise_parameter_sanitizer.for(:sign_in) << :attribute
# end
end
