class MuscleGroupsController < ApplicationController
  # GET /muscle_groups
  # GET /muscle_groups.xml
  def index
    @muscle_groups = MuscleGroup.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @muscle_groups }
    end
  end

  # GET /muscle_groups/1
  # GET /muscle_groups/1.xml
  def show
    @muscle_group = MuscleGroup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @muscle_group }
    end
  end

  # GET /muscle_groups/new
  # GET /muscle_groups/new.xml
  def new
    @muscle_group = MuscleGroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @muscle_group }
    end
  end

  # GET /muscle_groups/1/edit
  def edit
    @muscle_group = MuscleGroup.find(params[:id])
  end

  # POST /muscle_groups
  # POST /muscle_groups.xml
  def create
    @muscle_group = MuscleGroup.new(params[:muscle_group])

    respond_to do |format|
      if @muscle_group.save
        format.html { redirect_to(@muscle_group, :notice => 'Muscle group was successfully created.') }
        format.xml  { render :xml => @muscle_group, :status => :created, :location => @muscle_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @muscle_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /muscle_groups/1
  # PUT /muscle_groups/1.xml
  def update
    @muscle_group = MuscleGroup.find(params[:id])

    respond_to do |format|
      if @muscle_group.update_attributes(params[:muscle_group])
        format.html { redirect_to(@muscle_group, :notice => 'Muscle group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @muscle_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /muscle_groups/1
  # DELETE /muscle_groups/1.xml
  def destroy
    @muscle_group = MuscleGroup.find(params[:id])
    @muscle_group.destroy

    respond_to do |format|
      format.html { redirect_to(muscle_groups_url) }
      format.xml  { head :ok }
    end
  end
end
