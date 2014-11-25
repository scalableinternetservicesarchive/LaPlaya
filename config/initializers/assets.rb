# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( modernizr.js )
# Rails.application.config.assets.precompile += %w( solid/hoverex-all.css )
Rails.application.config.assets.precompile += [/solid\/.*\.jpg/]
Rails.application.config.assets.precompile += [/lightbox2\/img\/.*\.(png|gif)/]
Rails.application.config.assets.precompile += [/video\.js\/dist\/(font\/vjs\.(svg|eot|tff|woff)|video-js\/video-js.swf)/]
