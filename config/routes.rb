Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  # get ':controller/:action/:id'
  # post ':controller/:action/:id'
  get '/movies/samedirector/:id', to: 'movies#samedirector', as: :samedirector
end
