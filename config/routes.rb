Rails.application.routes.draw do
  resources :places
  resources :place_types
  devise_for :rangers
  resources :articles

  root 'welcome#index'
  get '/locations', to: 'welcome#locations'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
