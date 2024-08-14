class ImportProjectsController < ApplicationController
  before_action :set_import_project, only: %i[ show edit update destroy ]

  # GET /import_projects or /import_projects.json
  def index
    @import_projects = ImportProject.all
  end

  # GET /import_projects/1 or /import_projects/1.json
  def show
  end

  # GET /import_projects/new
  def new
    @import_project = ImportProject.new
  end

  # GET /import_projects/1/edit
  def edit
  end

  # POST /import_projects or /import_projects.json
  def create
    @import_project = ImportProject.new(import_project_params)

    respond_to do |format|
      if @import_project.save
        format.html { redirect_to import_project_url(@import_project), notice: "Import project was successfully created." }
        format.json { render :show, status: :created, location: @import_project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /import_projects/1 or /import_projects/1.json
  def update
    respond_to do |format|
      if @import_project.update(import_project_params)
        format.html { redirect_to import_project_url(@import_project), notice: "Import project was successfully updated." }
        format.json { render :show, status: :ok, location: @import_project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @import_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /import_projects/1 or /import_projects/1.json
  def destroy
    @import_project.destroy!

    respond_to do |format|
      format.html { redirect_to import_projects_url, notice: "Import project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import_project
      @import_project = ImportProject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def import_project_params
      params.require(:import_project).permit(:label, :organisation_id, :template, :token)
    end
end
