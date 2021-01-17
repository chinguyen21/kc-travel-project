Rails.application.routes.draw do
  
  get '/destinations/most_popular', to: "entries#most_popular_destination", as: "most_popular"
  resources :destinations
  resources :destinations, only: [:show, :index] do
    resources :events, only: [:show, :index]
  end
  resources :users

  resources :users, only: [:show, :index] do
        get 'welcome'
    resources :itineraries, except: [:new, :create, :edit, :update, :destroy] do 
      collection do 
        get 'archived'
      end
    end
    resources :favorites, only: :index
    resources :reviews, only: [:index, :edit]
  end
  resources :event_entries
  resources :entries
  resources :itineraries
  resources :events
  resources :favorites
  resources :reviews

  put '/users/:id/itineraries/:id/edit', to: 'entries#change_date', as: 'change_date'
  put '/users/:id/itineraries/:id', to: 'itineraries#archive', as: 'archive_itinerary'
  delete 'users/:id/reviews/:id', to: 'reviews#destroy', as: 'delete_review'

  root 'sessions#welcome', as: 'welcome'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
