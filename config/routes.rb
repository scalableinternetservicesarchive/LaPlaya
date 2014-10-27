Rails.application.routes.draw do
  resources :projects
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root 'static_pages#home'
  namespace 'solid' do
    get 'index', to: 'solid#index'
    get 'about', to: 'solid#about'
    get 'contact', to: 'solid#contact'
    get 'blog', to: 'solid#blog'
    get 'portfolio', to: 'solid#portfolio'
    get 'single-post', to: 'solid#single_post'
    get 'single-project', to: 'solid#single_project'
  end
end
