Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users

  root 'transactions#index'

  resources :users
  resources :transactions

  get '/account', to: 'users#account'
  get '/cashin', to: 'transactions#cashin'
  post '/cashin', to: 'transactions#cashin_post'
end
