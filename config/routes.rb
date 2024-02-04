Rails.application.routes.draw do
  devise_for :users

  root to: "homes#top"
  resources :users, only: [:index,:show,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
