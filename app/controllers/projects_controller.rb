class ProjectsController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :check_admin!, except: [:index, :show]
  respond_to :html, :json

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.all

    respond_with @projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    if not is_user?
      redirect_to new_project_submission_url(@project) and return
    end
    @submissions = Submission.where(:project_id => @project.id)

    respond_with @project
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_with @project
  end

  # GET /projects/1/edit
#  def edit
#    @project = Project.find(params[:id])
#  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
#  def update
#    @project = Project.find(params[:id])
#
#    respond_to do |format|
#      if @project.update_attributes(params[:project])
#        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @project.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
