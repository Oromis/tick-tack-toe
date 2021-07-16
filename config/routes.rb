Rails.application.routes.draw do
  namespace :api do
    post '/login' => 'sessions#create'
    get '/games' => 'games#index'
  end

  root to: 'static#index'
  get '*path', to: 'static#index'
end
