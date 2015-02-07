Rails.application.routes.draw do
  root :to => 'games#new'

  get '/games/new' => 'games#new'
  #will need to change this to /games/:id/roll_dice later
  post '/games/roll_again' => 'games#roll_again'


end
