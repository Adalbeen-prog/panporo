Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'homepages#index'
  get 'search', to: 'summoners#show'
  get 'live', to: 'summoners#live'
  get 'match/:id', to: 'summoners#match'
  
  resources :games  do
    resources :champions
  end
end
