Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  post 'set_profile_picture', to: 'users#set_profile_picture', as: :set_profile_picture
end
