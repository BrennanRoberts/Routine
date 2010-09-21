class MuscleGroup < ActiveRecord::Base
	has_many :muscles
	validates_presence_of :name
end
