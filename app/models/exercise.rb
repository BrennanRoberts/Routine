class Exercise < ActiveRecord::Base
	has_and_belongs_to_many :muscles
	has_many :workout_sets, :dependent => :destroy
	has_many :workouts, :through => :workout_sets
	validates_presence_of :name
	
	def muscle_groups
		MuscleGroup.joins(:muscles => :exercises).where(:exercises => {:id => id})
	end
end
