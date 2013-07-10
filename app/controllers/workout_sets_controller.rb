class WorkoutSetsController < ApplicationController
  def new 
    @workout_set = WorkoutSet.new(:workout_id => params[:workout_id], :exercise_id => params[:exercise_id])
  end
  
  def destroy
    @workout_set = WorkoutSet.find(params[:id])
    @workout_set.destroy

    respond_to do |format|
      format.html { redirect_to(exercises_url) }
      format.xml  { head :ok }
    end
  end
end
