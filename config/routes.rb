Rails.application.routes.draw do
  #Static Pages
  root 'static_pages#home'
  get 'upgrade', to: 'static_pages#upgrade'


  resources :galleries

  resources :projects do
    resources :comments, only: [:create, :destroy] do
      collection do
        get 'new/(:parent_id)', to: 'comments#new', as: 'new'
      end
    end
    member do
      post 'like'
      delete 'unlike'
    end
  end
  get 'projects/:id/comments/:comment_id', to: 'projects#show', as: 'project_comment_show'

  get 'profile/:id', to: 'profiles#show', as: 'profile'

  devise_for :users,
             controllers: {
                 omniauth_callbacks: 'users/omniauth_callbacks',
                 sessions: 'users/sessions',
                 registrations: 'users/registrations'
             },
             skip: [:registrations, :sessions]


  get 'signin', to: 'static_pages#home', as: 'new_user_session'



  devise_scope :user do
    namespace 'users', as: 'user' do
      get 'check_username', to: 'registrations#check_username'
      get 'check_email', to: 'registrations#check_email'
      get 'check_password', to: 'registrations#check_password'
      post 'preregistration', to: 'registrations#preregistration'
    end
    namespace 'users', as: 'user_registration' do
      post '', to: 'registrations#create'
      get 'edit', to: 'registrations#edit'
      patch '', to: 'registrations#update'
      put '', to: 'registrations#update'
      delete '', to: 'registrations#destroy'
    end
    namespace 'users', as: '' do
      post 'switch_user', to: 'sessions#switch_user', as: 'user_switch_user'
      post 'sign_in', to: 'sessions#create', as: 'user_session'
      delete 'sign_out', to: 'sessions#destroy', as: 'destroy_user_session'
    end
  end

  #Announcement reading
  mount Starburst::Engine => '/starburst'

  #Routes to showcase solid layout
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
