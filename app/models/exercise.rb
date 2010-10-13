class Exercise < ActiveRecord::Base
	has_many :musclegroupizations
	has_many :muscle_groups, :through => :musclegroupizations
	has_many :workout_sets, :dependent => :destroy
	has_many :workouts, :through => :workout_sets
	validates_presence_of :name
end
