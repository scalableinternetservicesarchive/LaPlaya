Rails.application.routes.draw do
  resources :galleries

  root 'static_pages#home'
end
