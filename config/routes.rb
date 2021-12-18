Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users

  root 'transactions#index'

  resources :users
  resources :transactions

  get '/account', to: 'users#account'
  get '/cashin', to: 'transactions#cashin'
  post '/cashin', to: 'transactions#cashin_post'
  get '/buy', to: 'transactions#buy'
  get '/purchase/:company/:price', to: 'transactions#purchase'
  post '/purchase/:company/:price', to: 'transactions#purchase_post'
  get '/portfolio', to: 'users#portfolio'
  get '/sell', to: 'transactions#sell'
  get '/sale/:company/:price', to: 'transactions#sale'
  post '/sale/:company/:price', to: 'transactions#sale_post'
  get '/user/new', to: 'users#new'
  post '/user/new', to: 'users#create'
  get '/user/:id/edit', to: 'users#edit'
  patch '/user/:id/edit', to: 'users#update'
end
