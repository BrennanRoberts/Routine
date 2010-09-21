class MeasurementUnit < ActiveRecord::Base
	has_many :workout_sets
end
