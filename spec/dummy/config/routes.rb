Rails.application.routes.draw do
  root 'appointments#index'

  resources :appointments, only: [:index, :new, :create]
end
