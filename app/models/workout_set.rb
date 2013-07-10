class WorkoutSet < ActiveRecord::Base
  belongs_to :workout
  belongs_to :exercise
  belongs_to :measurement_unit
  
  default_scope order('position')
  
  def exercise_name
    exercise ? exercise.name : nil
  end
end
