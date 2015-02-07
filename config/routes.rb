Rails.application.routes.draw do
  root :to => 'games#new'

  get '/games/new' => 'games#new'

end
