Rails.application.routes.draw do
  devise_for :users
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follows'
    get 'followers' => 'relationships#followers'
  end


  resources :books, except: [:new] do# bookとpost_commentとfavoriteをネスト
  	resources :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]# 単数にすると、そのコントローラのidがリクエストに含まれなくなります(今回はshowを作成しないため)
  end

  root 'home#top'
  get 'home/about'
end