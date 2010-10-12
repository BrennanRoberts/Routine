class MuscleGroup < ActiveRecord::Base
	has_many :muscles
	validates_presence_of :name
	
	default_scope order('name')
	
	def exercises
		Exercise.includes(:muscles => :muscle_group).where(:muscle_groups => {:id => id })
	end
end
