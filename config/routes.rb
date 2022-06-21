Rails.application.routes.draw do
  resources :addresses
  resources :municipes

  root to: 'municipes#index'
end
