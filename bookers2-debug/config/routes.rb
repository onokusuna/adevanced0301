Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books, except: [:new]
  root 'home#top'
  get 'home/about'
end