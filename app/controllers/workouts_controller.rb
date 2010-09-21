class WorkoutsController < ApplicationController
	# GET /workouts
	# GET /workouts.xml
	def index
		@workouts = current_user.workouts.order('date desc')

		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @workouts }
		end
	end
	
	def upcoming
		@workouts = current_user.workouts.upcoming	
		
		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @workouts }
		end	
	end
	
	def completed
		@workouts = current_user.workouts.completed
		
		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @workouts }
		end
	end

	def incomplete
		@workouts = current_user.workouts.forgotten
		
		respond_to do |format|
			format.html # index.html.erb
			format.xml	{ render :xml => @workouts }
		end
	end
	
	# GET /workouts/1
	# GET /workouts/1.xml
	def show
		@workout = current_user.workouts.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml	{ render :xml => @workout }
		end
	end

	# GET /workouts/new
	# GET /workouts/new.xml
	def new
		@workout = Workout.new
		1.times { @workout.workout_sets.build }
		respond_to do |format|
			format.html # new.html.erb
			format.xml	{ render :xml => @workout }
		end
	end

	# GET /workouts/1/edit
	def edit
		@workout = Workout.find(params[:id])
	end

	# POST /workouts
	# POST /workouts.xml
	def create
		@workout = Workout.new(params[:workout])

		respond_to do |format|
			if @workout.save
				format.html { redirect_to(@workout, :notice => 'Workout was successfully created.') }
				format.xml	{ render :xml => @workout, :status => :created, :location => @workout }
			else
				format.html { render :action => "new" }
				format.xml	{ render :xml => @workout.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /workouts/1
	# PUT /workouts/1.xml
	def update
		@workout = Workout.find(params[:id])

		respond_to do |format|
			if @workout.update_attributes(params[:workout])
				format.html { redirect_to(@workout, :notice => 'Workout was successfully updated.') }
				format.xml	{ head :ok }
			else
				format.html { render :action => "edit" }
				format.xml	{ render :xml => @workout.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	# def complete 
# 		@workout = Workout.find(params[:id])
# 		@task.update_attributes :complete, true
# 		redirect_to workouts_path 
# 	end

	# DELETE /workouts/1
	# DELETE /workouts/1.xml
	def destroy
		@workout = Workout.find(params[:id])
		@workout.destroy

		respond_to do |format|
			format.html { redirect_to(workouts_url) }
			format.xml	{ head :ok }
		end
	end
end
