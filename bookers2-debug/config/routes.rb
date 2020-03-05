Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update]
  resources :books, except: [:new] do# bookとpost_commentとfavoriteをネスト
  	resource :favorites, only: [:create, :destroy]
    resource :post_comments, only: [:create]# 単数にすると、そのコントローラのidがリクエストに含まれなくなります(今回はshowを作成しないため)
  end
  root 'home#top'
  get 'home/about'
end