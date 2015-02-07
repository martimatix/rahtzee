class GamesController < ApplicationController
  def new
    dice = roll_dice
    @turn = Turn.create(dice_hash(dice))

    @fields = %w(ones twos threes fours fives sixes
                 subtotal bonus upper_score_total
                 three_of_a_kind four_of_a_kind full_house
                 small_straight large_straight rahtzee)
  end

  def roll_again
    # turn.last is crude need to change to turn id
    @turn = Turn.last    
    roll_count = @turn.roll_counter
    if roll_count >= 3
      redirect_to(games_error_path) 
      return
    end
    @turn.update :roll_counter => (roll_count + 1)

    # Roll Dice
    dice_to_roll = dice_check(params)
    dice_to_roll.each_with_index do |user_chose_to_roll_die, i|
      eval("@turn.update :dice_#{ i+1 } => rand(1..6)") if user_chose_to_roll_die
    end

    @fields = %w(ones twos threes fours fives sixes
             subtotal bonus upper_score_total
             three_of_a_kind four_of_a_kind full_house
             small_straight large_straight rahtzee)

    render "new"
  end

  def error
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
end