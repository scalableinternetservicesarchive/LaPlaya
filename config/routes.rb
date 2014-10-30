Rails.application.routes.draw do
  resources :projects

  devise_for :users
  root 'static_pages#home'
end
