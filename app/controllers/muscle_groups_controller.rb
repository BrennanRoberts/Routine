class MuscleGroupsController < ApplicationController
  def index
    @muscle_groups = MuscleGroup.all
  end

	def ajax_exercises
		@muscle_group = MuscleGroup.find(params[:id])
		
		render :layout => false
	end

  def show
    @muscle_group = MuscleGroup.find(params[:id])
  end

  def new
    @muscle_group = MuscleGroup.new
  end

  def edit
    @muscle_group = MuscleGroup.find(params[:id])
  end

  def create
    @muscle_group = MuscleGroup.new(params[:muscle_group])

    if @muscle_group.save
      redirect_to(muscle_groups_path, :notice => 'Muscle group was successfully created.') 
    else
      render :action => "new" 
    end
  end

  def update
    @muscle_group = MuscleGroup.find(params[:id])
    
    if @muscle_group.update_attributes(params[:muscle_group])
      redirect_to(muscle_groups_path, :notice => 'Muscle group was successfully updated.')
    else
			render :action => "edit"
 
    end
  end

  def destroy
    @muscle_group = MuscleGroup.find(params[:id])
    @muscle_group.destroy

		redirect_to(muscle_groups_url)
  end
end
