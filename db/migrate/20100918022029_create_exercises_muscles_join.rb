class CreateExercisesMusclesJoin < ActiveRecord::Migration
  def self.up
  	create_table 'exercises_muscles', :id => false do |t|
  		t.integer 'exercise_id'
  		t.integer 'muscle_id'
  	end
  end

  def self.down
  	drop_table 'exercises_muscles'
  end
end
