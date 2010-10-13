class Musclegroupization < ActiveRecord::Base
	belongs_to :exercise
	belongs_to :muscle_group
end
