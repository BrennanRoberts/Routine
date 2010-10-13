class ExercisesController < ApplicationController
  # GET /exercises
  # GET /exercises.xml
  def index
	  @exercises = Exercise.all
  end
  
  def ajax_search
  	@exercises = Exercise.where('name LIKE ?', "#{params[:query]}%")
  	render :layout => false
  end

  def show
    @exercise = Exercise.find(params[:id])
  end

  def new
    @exercise = Exercise.new
  end

  def edit
    @exercise = Exercise.find(params[:id])
  end

  def create
    @exercise = Exercise.new(params[:exercise])

    if @exercise.save
      redirect_to(exercises_path, :notice => 'Exercise was successfully created.') 
    else
			render :action => "new"
    end
  end

  # PUT /exercises/1
  # PUT /exercises/1.xml
  def update
  	params[:exercise][:muscle_group_ids] ||= []
    @exercise = Exercise.find(params[:id])

		if @exercise.update_attributes(params[:exercise])
			redirect_to(@exercise, :notice => 'Exercise was successfully updated.')
		else
			render :action => "edit"
    end
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.xml
  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy

    respond_to do |format|
      format.html { redirect_to(exercises_url) }
      format.xml  { head :ok }
    end
  end
end
