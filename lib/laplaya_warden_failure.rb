class LaplayaWardenFailure < Devise::FailureApp
  def redirect_url
    root_path signin: true
  end
end