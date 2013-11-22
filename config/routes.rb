UrbanHitchHiker::Application.routes.draw do

  resources :profiles, :only => [:edit, :show, :update]

  resources :trips do
      resources 'comments', :only => [:create]
      resources :bookings, :only => [:index, :show, :new, :create, :destroy]
  end

  resources :conversations
  resources :messages

  get "home/index"

  devise_for :users

  root :to => "home#index"

end
