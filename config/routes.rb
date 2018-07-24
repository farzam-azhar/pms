Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  post 'set_profile_picture', to: 'users#set_profile_picture', as: :set_profile_picture
  
  namespace 'admin' do
    root 'users#index'
    resources :users, only: [:index] do
      member do
        get 'update_status'
        get 'update_role'
      end
    end
  end
  
  resources :clients
  resources :projects
end
