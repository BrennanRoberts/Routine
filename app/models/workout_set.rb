class WorkoutSet < ActiveRecord::Base
	belongs_to :workout
	belongs_to :exercise
	belongs_to :measurement_unit
end
