Rails.application.routes.draw do
  devise_for :members
  root "home#index"
  resources :tasks
  resources :members, only: %i[index show]
end
