class InspectionsController < ApplicationController
  before_action :set_inspection, only: %i[ show edit update destroy ]

  # GET /inspections or /inspections.json
  def index
    @inspections = Inspection.all
  end

  # GET /inspections/1 or /inspections/1.json
  def show
  end

  # GET /inspections/new
  def new
    @inspection = Inspection.new
  end

  # GET /inspections/1/edit
  def edit
  end

  # POST /inspections or /inspections.json
  def create
    @inspection = Inspection.new(inspection_params)

    respond_to do |format|
      if @inspection.save
        format.html { redirect_to inspection_url(@inspection), notice: "Inspection was successfully created." }
        format.json { render :show, status: :created, location: @inspection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inspections/1 or /inspections/1.json
  def update
    respond_to do |format|
      if @inspection.update(inspection_params)
        format.html { redirect_to inspection_url(@inspection), notice: "Inspection was successfully updated." }
        format.json { render :show, status: :ok, location: @inspection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspections/1 or /inspections/1.json
  def destroy
    @inspection.destroy!

    respond_to do |format|
      format.html { redirect_to inspections_url, notice: "Inspection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inspection
      @inspection = Inspection.find(params[:id])
      @hilti_project = @inspection.hilti_project
      @hilti_import = @hilti_project.hilti_import
      @import_project = @hilti_import.import_project
    end

    # Only allow a list of trusted parameters through.
    def inspection_params
      params.require(:inspection).permit(:hilti_import_id, :hilti_project_id, :clarinspect_id, :reference, :project_id, :category_id, :penetration, :clarinspect_inspection)
    end
end
