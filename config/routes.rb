Rails.application.routes.draw do
  resources :galleries

  resources :projects
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions'}

  resources :comments, only: [:index, :new, :create, :show, :destroy]

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

  devise_scope :user do
    namespace 'users' do
      get 'check_username', to: 'registrations#check_username'
      get 'check_email', to: 'registrations#check_email'
      get 'switch_user', to: 'switch_user#set_current_user'
    end
  end

end
