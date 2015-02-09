require 'scoring.rb'

class GamesController < ApplicationController
  include Scoring

  def new
    dice = roll_dice
    @turn = Turn.create(dice_hash(dice))
    @game = Game.create
    @current_user.games << @game

    render "game"
  end

  def roll_again
    # turn.last is crude need to change to turn id
    @game = Game.find params[:game_id]
    @turn = Turn.find params[:turn_id]  
    roll_count = @turn.roll_counter
    @turn.update :roll_counter => (roll_count + 1)

    # Roll Dice
    dice_to_roll = dice_check(params)
    dice_to_roll.each_with_index do |user_chose_to_roll_die, i|
      @turn.send("dice_#{ i+1 }=", rand(1..6)) if user_chose_to_roll_die
      @turn.save
    end

    render "game"
  end

  def enter_score
    @game = Game.find params[:game_id]
    @turn = Turn.find params[:turn_id] 

    dice = extract_dice(@turn)
    score_field = params['score_field']
    score = eval("#{score_field}(dice)")
    
    @game.send(score_field + '=', score)
    @game.save

    if game_over?
      redirect_to games_game_over_path
    else
      dice = roll_dice
      @turn = Turn.create(dice_hash(dice)) 
      redirect_to :controller => 'games', :action => 'new_turn',
                  :game_id => @game.id, :turn_id => @turn.id
    end
  end

  def new_turn
    @game = Game.find params[:game_id]
    @turn = Turn.find params[:game_id]

    render "game"
  end

  def game_over
  end

  private
  def roll_dice(dice = [true]*5)
    dice.map! {|d| rand(1..6) if d}
    dice
  end

  def dice_hash(dice)
    hash = {}
    (1..5).each do |i|
      hash["dice_#{i}".to_sym] = dice[i-1]
    end
    hash
  end

  def dice_check(params)
    dice_to_roll = []
    (1..5).each do |i|
      dice_to_roll[i - 1] = params.keys.include? "dice_#{i}"
    end
    dice_to_roll
  end

  def extract_dice(turn)
    dice = []
    (1..5).to_a.each { |i| dice << eval("turn.dice_#{i}") }
    dice
  end

  def game_over?
    game = Game.find params[:game_id]
    Game.fields.all? {|f| game.send f}
  end 
      
end