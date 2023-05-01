Rails.application.routes.draw do
  get 'chats/show'
  get 'chats/create'
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'daily_posts' => 'users#daily_posts'
  end
  
  get 'chat/:id' => 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  
  resources :groups do
    get "join" => "groups#join"
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end
  
  get '/search', to: 'searches#search'
end