Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  root to: "messages#index"
  # ルートパスへのアクセスがあったら、messages_controllerのindexアクションが呼び出される
  resources :users, only: [:edit, :update]
  resources :rooms, only: [:new, :create]
end
