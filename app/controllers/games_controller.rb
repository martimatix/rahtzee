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
    # turn.last is crude
    roll_count = Turn.last.roll_counter
    @dice = roll_dice
    @turn = Turn.last
    Turn.last.update :roll_counter => (roll_count + 1)

    @fields = %w(ones twos threes fours fives sixes
             subtotal bonus upper_score_total
             three_of_a_kind four_of_a_kind full_house
             small_straight large_straight rahtzee)

    render "new"
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
end