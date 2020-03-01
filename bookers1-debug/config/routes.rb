Rails.application.routes.draw do
  # root追記
  root :to => 'home#top'
  resources :books

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
