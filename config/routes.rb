Rails.application.routes.draw do
  devise_for :users
  root "restaurants#index"

  namespace :admin do
    get "dashboard/index"
  end

  get "up" => "rails/health#show", as: :rails_health_check

  resources :restaurants
end
