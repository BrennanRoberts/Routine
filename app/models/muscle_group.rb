class MuscleGroup < ActiveRecord::Base
	has_many :musclegroupizations
	has_many :exercises, :through => :musclegroupizations
	
	validates_presence_of :name
	
	default_scope order('name')
end
