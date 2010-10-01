module WorkoutsHelper
	def workout_subnav
		nav = link_to("Upcoming", upcoming_workouts_path) 
		nav << ' | ' 
		nav << link_to('Completed', completed_workouts_path)
		nav << ' | ' 
		nav << link_to("Incomplete", incomplete_workouts_path)
	end
	
	def get_muscle_groups(exercise)
		mgs = exercise.muscles.collect { |muscle| muscle.muscle_group }
		mgs.uniq!
		html = ""
		mgs.each do |mg|
			html << muscle_group_tag(mg)
		end
		html.html_safe
	end
	
	def muscle_group_tag(mg)

	content_tag(:span, content_tag(:span, mg.name, :class=> "muscle-bubble-inner"), :class =>"muscle-bubble round-rect #{mg.name.downcase}")
	end
end
