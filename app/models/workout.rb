class Workout < ActiveRecord::Base
	belongs_to :user
	has_many :workout_sets
	has_many :exercises, :through => :workout_sets
	accepts_nested_attributes_for :workout_sets, :allow_destroy => true
	
	def self.upcoming
		where("date >= ?", Date.today).order('date asc')		
	end
	
	def self.completed
		find_all_by_complete(true)
	end
	
	def self.forgotten
		where("complete = ? and date < ?", false, Date.today)
	end
end
