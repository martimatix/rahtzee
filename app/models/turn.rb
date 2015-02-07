# == Schema Information
#
# Table name: turns
#
#  id           :integer          not null, primary key
#  dice_1       :integer
#  dice_2       :integer
#  dice_3       :integer
#  dice_4       :integer
#  dice_5       :integer
#  roll_counter :integer
#  game_id      :integer
#  turn_over    :boolean          default("false")
#  created_at   :datetime
#  updated_at   :datetime
#

class Turn < ActiveRecord::Base
  belongs_to :game
end
