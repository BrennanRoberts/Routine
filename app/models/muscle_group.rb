class MuscleGroup < ActiveRecord::Base
	has_many :muscles
	validates_presence_of :name
	
	default_scope order('name')
end
