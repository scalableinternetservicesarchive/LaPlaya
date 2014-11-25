class LaplayaWardenFailure < Devise::FailureApp

  #When we can't sign in, simply load the homepage with the login modal shown.
  def redirect_url
    root_path signin: true
  end
end