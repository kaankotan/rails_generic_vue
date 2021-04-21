Rails.application.routes.draw do
  resources :users
  get 'home/index'
  root to: 'home#index'
  scope "/api", defaults: {format: :json} do
    resources :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
