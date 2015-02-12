require 'scoring.rb'

class GamesController < ApplicationController
  include Scoring

  def new
    dice = roll_dice
    @game = Game.create(dice_hash(dice))
    @current_user.games << @game
    @dice_to_hold = [false] * 5
    @suggestions = suggestions

    render "game"
  end

  def roll_again
    @game = Game.find params[:game_id] 
    @suggestions = suggestions
    @dice_to_hold = dice_check(params)

    roll_count = @game.roll_counter
    @game.update :roll_counter => (roll_count + 1)

    # Roll Dice
    @dice_to_hold.each_with_index do |user_chose_to_hold_die, i|
      @game.send("dice_#{ i+1 }=", rand(1..6)) unless user_chose_to_hold_die
      @game.save
    end

    render "game"
  end

  def enter_score
    @game = Game.find params[:game_id]
    @suggestions = suggestions

    score_field = params['score_field']

    if score_field.nil?
      @dice_to_hold = [false] * 5
      render "game" 
      return
    end

    dice = extract_dice(@game)
    score = eval("#{score_field}(dice)")
    
    @game.send(score_field + '=', score)
    dice = roll_dice
    @game.update(dice_hash(dice))
    @game.roll_counter = 1
    @game.save

    update_score_sheet

    if @game.filled
      redirect_to :controller => 'games', :action => 'game_over',
                  :game_id => @game.id
    else
      redirect_to :controller => 'games', :action => 'new_turn',
                  :game_id => @game.id
    end
  end

  def new_turn
    @game = Game.find params[:game_id]
    @suggestions = suggestions
    @dice_to_hold = [false] * 5

    render "game"
  end

  def game_over
    @game = Game.find params[:game_id]
  end

  ########################### Private Methods ###########################

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
      dice_to_hold = []
      (1..5).each do |i|
        dice_to_hold[i - 1] = params.keys.include? "dice_#{i}"
      end
      dice_to_hold
    end

    def extract_dice(turn)
      dice = []
      (1..5).to_a.each { |i| dice << eval("turn.dice_#{i}") }
      dice
    end

    # Raw upper score total (no bonus)
    def raw_upper
      upper_values = Game.upper_scores.map {|f| @game.send(f).to_i }
      @game.raw_upper = upper_values.reduce(:+)
    end

    def upper_score_bonus
      @game.upper_score_bonus = 35 if @game.raw_upper > 62
    end

    def upper_score
      @game.upper_score = @game.raw_upper + @game.upper_score_bonus
    end

    def lower_score
      lower_values = Game.lower_scores.map {|f| @game.send(f).to_i }
      @game.lower_score = lower_values.reduce(:+)
    end

    def total_score
      @game.total_score = @game.upper_score + @game.lower_score
    end

    def update_score_sheet
      raw_upper
      upper_score_bonus
      upper_score
      lower_score
      total_score
      @game.filled = true if game_over?
      @game.save
    end

    # Generates a hash of suggested scores
    def suggestions
      turn_dice = extract_dice(@game)
      Hash[ *Game.fields.collect { |field| [ field, eval("#{field}(turn_dice)") ] }.flatten ]
    end

    def game_over?
      game = Game.find params[:game_id]
      Game.fields.all? {|f| game.send f}
    end 
      
end