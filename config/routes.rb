Rails.application.routes.draw do
  root :to => 'games#new'

  get '/games/new' => 'games#new'
  # to do: add user id to path for greater verification
  post '/games/:game_id/:turn_id/roll_again' => 'games#roll_again'
  post '/games/:game_id/:turn_id/enter_score' => 'games#enter_score'
  get '/games/:game_id/:turn_id/error' => 'games#error'
  # todo: merge games#new_turn with games#new
  get '/games/:game_id/new_turn' => 'games#new_turn'


end
