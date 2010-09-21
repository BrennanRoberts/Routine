class Muscle < ActiveRecord::Base
	has_and_belongs_to_many :exercises
	belongs_to :muscle_group
	validates_presence_of :name, :muscle_group_id
end
