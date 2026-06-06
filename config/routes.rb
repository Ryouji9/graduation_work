Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"
  get 'terms', to: 'static_pages#terms'
  get 'privacy', to: 'static_pages#privacy'
  get 'selections/new', to: 'selections#new', as: 'new_selection'
  post 'selections', to: 'selections#create', as: 'selections'
end
