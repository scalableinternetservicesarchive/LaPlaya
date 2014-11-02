class Users::SwitchUserController < SwitchUserController

  def set_current_user
    if params[:remember] == 'true'
      remember_user
      handle_request(params)
    else
      super
    end
  end

end