class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.order(:name)
  end

  def ajax_search
    @exercises = Exercise.where('name LIKE ?', "%#{params[:query]}%")
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

  def update
    params[:exercise][:muscle_group_ids] ||= []
    @exercise = Exercise.find(params[:id])

    if @exercise.update_attributes(params[:exercise])
      redirect_to(exercises_path, :notice => 'Exercise was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy

    redirect_to(exercises_url)
  end
end
