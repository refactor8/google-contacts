Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/users/auth/failure', to: 'users/omniauthcallbacks#failure'
  get '/contacts', to: 'contacts#index', as: 'contacts'
  post '/contacts/pull', to: 'contacts#pull', as: 'pull_contacts'
end
