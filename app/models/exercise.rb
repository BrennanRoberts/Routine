class Exercise < ActiveRecord::Base
	has_and_belongs_to_many :muscles
	
	validates_presence_of :name
end
