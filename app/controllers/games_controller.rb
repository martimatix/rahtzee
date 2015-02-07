class GamesController < ApplicationController
  def new
    @dice = roll_dice
    Turn.create(dice_hash(@dice))

    @fields = %w(ones twos threes fours fives sixes
                 subtotal bonus upper_score_total
                 three_of_a_kind four_of_a_kind full_house
                 small_straight large_straight rahtzee)
  end

  def roll_again
    redirect_to(games_new_path)
  end

  private
  def roll_dice(dice = [true]*5)
    dice.map! {|d| rand(1..6) if d}
    dice
  end

  def dice_hash(dice)
    hash = {}
    (1..5).each do |i|
      hash["dice_#{i}".to_sym] = dice[i]
    end
    hash
  end
end