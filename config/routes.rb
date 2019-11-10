Rails.application.routes.draw do
  resources :beer_types, only: [:index, :create, :delete] do
    get :beers, to: "beers#by_beer_type"
    get :ranking, to: "ranking#index_by_beer_type"
  end
  resources :beers do
    get :votes, to: "votes#by_beer"
  end
  resources :producers do
    get :beers, to: "beers#by_producer"
    get :votes, to: "votes#by_producer"
  end
  resources :votes
  resources :users, only: [:index, :show, :delete] do
    match "block", to: "user#block", via: [:put, :patch]
    match "active", to: "user#active", via: [:put, :patch]
    get :votes, to: "votes#by_user"
  end
  get :ranking, to: "ranking#index"
  post '/auth/login', to: 'authentication#login'
end
