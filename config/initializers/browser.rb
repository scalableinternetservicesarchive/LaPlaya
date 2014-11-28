Rails.configuration.middleware.use Browser::Middleware do
  unless (browser.modern? || request.path == upgrade_path)
    Rails.logger.info 'Completed 302 for Browser Upgrade redirect'
    redirect_to upgrade_path
  end
end