Rails.application.routes.draw do
  get 'projects/create'

  get 'projects/show'

  get 'projects/destroy'

  get 'projects/index'

  get 'projects/new'

  get 'projects/edit'

  get 'projects/update'

  get 'projects/view'

  get 'projects/delete'

  devise_for :users
  root 'static_pages#home'
end
