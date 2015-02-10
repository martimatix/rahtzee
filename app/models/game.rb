# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  total_score       :integer          default("0")
#  filled            :boolean          default("false")
#  dice_1            :integer
#  dice_2            :integer
#  dice_3            :integer
#  dice_4            :integer
#  dice_5            :integer
#  roll_counter      :integer          default("1")
#  ones              :integer
#  twos              :integer
#  threes            :integer
#  fours             :integer
#  fives             :integer
#  sixes             :integer
#  raw_upper         :integer
#  upper_score_bonus :integer          default("0")
#  upper_score       :integer
#  three_of_a_kind   :integer
#  four_of_a_kind    :integer
#  full_house        :integer
#  small_straight    :integer
#  large_straight    :integer
#  chance            :integer
#  rahtzee           :integer
#  lower_score       :integer
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Game < ActiveRecord::Base
  belongs_to :user

  def self.fields
    %w(ones twos threes fours fives sixes
       three_of_a_kind four_of_a_kind full_house
       small_straight large_straight chance rahtzee)
  end


  def self.upper_scores
    [:ones, :twos, :threes, :fours, :fives, :sixes]
  end
  
  def self.lower_scores
    [:three_of_a_kind, :four_of_a_kind, :full_house,
     :small_straight, :large_straight, :chance, :rahtzee]
  end

end
