class WorkoutSetController < ApplicationController
	def destroy
    @workout_set = WorkoutSet.find(params[:id])
    @workout_set.destroy

    respond_to do |format|
      format.html { redirect_to(exercises_url) }
      format.xml  { head :ok }
    end
  end
end
