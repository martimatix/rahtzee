class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      # General
      t.integer :total_score
      t.boolean :filled, :default => false

      # Upper Scores
      t.integer :ones
      t.integer :twos
      t.integer :threes
      t.integer :fours
      t.integer :fives
      t.integer :sixes
      t.integer :raw_upper
      t.integer :bonus_upper_score
      t.integer :upper_score

      # Lower Scores
      t.integer :three_of_a_kind
      t.integer :four_of_a_kind
      t.integer :full_house
      t.integer :small_straight
      t.integer :large_straight
      t.integer :chance
      t.integer :rahtzee
      t.integer :lower_score

      # Administration
      t.integer :user_id
      t.timestamps
    end
  end
end
