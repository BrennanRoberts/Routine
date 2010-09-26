class ExercisesController < ApplicationController
  # GET /exercises
  # GET /exercises.xml
  def index
  	if params[:muscle_group]
			@exercises = Exercise.search_by_muscle_group(params[:muscle_group], params[:query])
		else
		  @exercises = Exercise.where('name LIKE ?', "#{params[:query]}%").includes(:muscles)
		end
		
    respond_to do |format|
      format.html # index.html.erb
     	format.js { render :json => @exercises }
    end
  end
  
  def autocomplete
  	if params[:muscle_group]
  		
  	elsif
  		@exercises = Exercise.all
  	end
  	
  	#@exercises = @exercise.where('name LIKE ?', "#{params[:term]}%").includes(:muscles)
  	respond_to do |format|
	  	format.json { render :json => @exercises }
	  end
  end

  # GET /exercises/1
  # GET /exercises/1.xml
  def show
    @exercise = Exercise.find(params[:id])

  end

  # GET /exercises/new
  # GET /exercises/new.xml
  def new
    @exercise = Exercise.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exercise }
    end
  end

  # GET /exercises/1/edit
  def edit
    @exercise = Exercise.find(params[:id])
  end

  # POST /exercises
  # POST /exercises.xml
  def create
    @exercise = Exercise.new(params[:exercise])

    respond_to do |format|
      if @exercise.save
        format.html { redirect_to(@exercise, :notice => 'Exercise was successfully created.') }
        format.xml  { render :xml => @exercise, :status => :created, :location => @exercise }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @exercise.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exercises/1
  # PUT /exercises/1.xml
  def update
  	params[:exercise][:muscle_ids] ||= []
    @exercise = Exercise.find(params[:id])

    respond_to do |format|
      if @exercise.update_attributes(params[:exercise])
        format.html { redirect_to(@exercise, :notice => 'Exercise was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @exercise.errors, :status => :unprocessable_entity }
      end
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
