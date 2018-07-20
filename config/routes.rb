Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  post 'set_profile_picture', to: 'users#set_profile_picture', as: :set_profile_picture
  
  namespace 'admin' do
    root 'users#index'
    resources :users do
      member do
        get 'enable_or_disable_user'
        get 'promote_to_manager_or_demote_to_user'
      end
    end
  end
  
  resources :clients
end
