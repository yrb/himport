class HiltiProjectsController < ApplicationController
  before_action :set_hilti_project, only: %i[ show edit update destroy ]

  # GET /hilti_projects or /hilti_projects.json
  def index
    @hilti_projects = HiltiProject.all
  end

  # GET /hilti_projects/1 or /hilti_projects/1.json
  def show
  end

  # GET /hilti_projects/new
  def new
    @hilti_project = HiltiProject.new
  end

  # GET /hilti_projects/1/edit
  def edit
  end

  # POST /hilti_projects or /hilti_projects.json
  def create
    @hilti_project = HiltiProject.new(hilti_project_params)

    respond_to do |format|
      if @hilti_project.save
        format.html { redirect_to hilti_project_url(@hilti_project), notice: "Hilti project was successfully created." }
        format.json { render :show, status: :created, location: @hilti_project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hilti_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hilti_projects/1 or /hilti_projects/1.json
  def update
    respond_to do |format|
      if @hilti_project.update(hilti_project_params)
        format.html { redirect_to hilti_project_url(@hilti_project), notice: "Hilti project was successfully updated." }
        format.json { render :show, status: :ok, location: @hilti_project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hilti_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hilti_projects/1 or /hilti_projects/1.json
  def destroy
    @hilti_project.destroy!

    respond_to do |format|
      format.html { redirect_to hilti_projects_url, notice: "Hilti project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hilti_project
      @hilti_project = HiltiProject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hilti_project_params
      params.require(:hilti_project).permit(:name, :address, :configuration_string)
    end
end
