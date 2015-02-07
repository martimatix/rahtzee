class CreateTurns < ActiveRecord::Migration
  def change
    create_table :turns do |t|
      t.integer :dice_1
      t.integer :dice_2
      t.integer :dice_3
      t.integer :dice_4
      t.integer :dice_5

      t.integer :roll_counter

      t.integer :game_id

      t.boolean :turn_over, :default => false

      t.timestamps
    end
  end
end
