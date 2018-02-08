require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  mount Sidekiq::Web => '/sidekiq'

  root to: 'home#home'
  
  resources :orders do
    post 'billing', on: :member
    # post 'raffle', on: :collection
  end


  get 'customers/:token/opened', to: 'customers#opened'
  resources :customers
  resources :services
  resources :orders

  get 'refresh', to: :refresh, controller: 'orders'

end