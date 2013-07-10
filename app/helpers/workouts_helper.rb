module WorkoutsHelper
  def workout_subnav
    nav = link_to("Upcoming", upcoming_workouts_path) 
    nav << ' | ' 
    nav << link_to('Completed', completed_workouts_path)
    nav << ' | ' 
    nav << link_to("Incomplete", incomplete_workouts_path)
  end
end
