class WorkoutsController < ApplicationController
  def index
    @upcoming_workouts =  current_user.workouts.today.incomplete | current_user.workouts.future
    @past_workouts = current_user.workouts.today.complete | current_user.workouts.past
  end

  def show
    @workout = current_user.workouts.find(params[:id])
  end

  def new
    if params[:type]
      new_params = {:date => Date.today}
      case params[:type]
        when "log"
          new_params[:complete] = true
      end
      @workout = Workout.new(new_params)
    else
      @workout = Workout.new
    end
  end

  def edit
    @workout = Workout.find(params[:id])
  end

  def create
    puts '***'
    puts workout_params
    @workout = current_user.workouts.new(workout_params)

    if @workout.save
      redirect_to( edit_workout_path(@workout), :notice => 'Workout was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @workout = Workout.find(params[:id])

    if @workout.update_attributes(workout_params)
      #redirect_to( edit_workout_path(@workout), :notice => 'Workout was successfully updated.')
      redirect_to( workouts_path, :notice => 'Workout was successfully updated.')
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
    respond_to do |format|
      format.html {redirect_to workouts_url, :notice => 'Marked workout as complete'}
      format.js {  }
    end
  end

  private

    def workout_params
      params.require(:workout).permit(:date, :complete, workout_sets_attributes: [:id, :weight, :magnitude, :exercise_id, :position])
    end
end
