require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :transactions
  resources :users
  get '/rewards' => 'users_rewards#index', as: 'rewards'
  root 'transactions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
