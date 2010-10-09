class ChangeWorkoutSetOrderToWorkoutSetPosition < ActiveRecord::Migration
  def self.up
  	remove_column :workout_sets, :order
  	add_column :workout_sets, :position, :integer
  end

  def self.down
  	  remove_column :workout_sets, :position
	  	add_column :workout_sets, :order, :integer
  end
end
