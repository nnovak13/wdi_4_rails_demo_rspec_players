Rails.application.routes.draw do
  root 'players#index'
  resources :players, only: [:new, :create]
end
