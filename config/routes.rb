Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", registrations: "users/registrations"}
  root 'home#index'

  get 'privacy', to: 'home#privacy', as: 'privacy'

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

  namespace 'charts' do
    get 'current_month_earnings'
    get 'current_month_time_logs'
    get 'by_month_earnings'
    get 'by_month_logs'
  end

  namespace 'api', format: :json do
    namespace 'v1' do
      post 'auth', to: 'authentication#create'
      resources :clients
      resources :projects do
        get 'search', on: :collection
      end
    resources :time_logs
    end
  end

  resources :clients do
    get 'update_status', on: :member
  end
  resources :projects do
    get 'mark_completed', on: :member
    resources :payments, only: [:new, :create, :edit, :update, :destroy]
    resources :assignments, only: [:new, :create, :edit, :update, :destroy]
    resources :comments, shallow: true
  end
  resources :time_logs
end
