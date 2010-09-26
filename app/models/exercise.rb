class Exercise < ActiveRecord::Base
	has_and_belongs_to_many :muscles
	has_many :workout_sets, :dependent => :destroy
	has_many :workouts, :through => :workout_sets
	validates_presence_of :name
	
	def self.search_by_muscle_group(mg_id, query)
		query ||= ''
		mg = MuscleGroup.find(mg_id)
  	muscles = mg.muscles
  	muscles.collect { |m| m.exercises.where('name LIKE ?', "#{query}%") }.flatten.uniq
	end
end
