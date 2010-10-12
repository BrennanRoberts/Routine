class WorkoutsController < ApplicationController
	def index
		@upcoming_workouts =  current_user.workouts.today.incomplete | current_user.workouts.future
		@past_workouts = current_user.workouts.today.complete | current_user.workouts.past
	end
		
	def show
		@workout = current_user.workouts.find(params[:id])
	end

	def new
		@workout = Workout.new
	end

	def edit
		@workout = Workout.find(params[:id])
	end

	def create
		@workout = current_user.workouts.new(params[:workout])

		if @workout.save
			redirect_to( edit_workout_path(@workout), :notice => 'Workout was successfully created.')
		else
			render :action => "new" 
		end
	end

	def update
		@workout = Workout.find(params[:id])

		if @workout.update_attributes(params[:workout])
			redirect_to( edit_workout_path(@workout), :notice => 'Workout was successfully updated.') 
		else
			render :action => "edit"
		end
	end

	def destroy
		@workout = Workout.find(params[:id])
		@workout.destroy

		redirect_to(workouts_url)
	end
	
	def complete
		@workout = Workout.find(params[:id])
		@workout.update_attribute :complete, true
		redirect_to workouts_url, :notice => 'Marked workout as complete'
	end
end
