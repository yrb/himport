class HiltiImportsController < ApplicationController
  before_action :set_hilti_import, only: %i[ show edit update destroy sync_images ]

  # GET /hilti_imports or /hilti_imports.json
  def index
    @hilti_imports = HiltiImport.all
  end

  # GET /hilti_imports/1 or /hilti_imports/1.json
  def show
  end

  # GET /hilti_imports/new
  def new
    @hilti_import = HiltiImport.new import_project_id: params[:import_project_id]
  end

  # GET /hilti_imports/1/edit
  def edit
  end

  def sync_images
    @hilti_import.inspection_images.find_in_batches do |group|
      group.each(&:sync)
    end

    respond_to do |format|
      format.html { redirect_to hilti_import_url(@hilti_import), notice: "Image sync started" }
    end
  end

  # POST /hilti_imports or /hilti_imports.json
  def create
    @hilti_import = HiltiImport.new(hilti_import_params)

    respond_to do |format|
      if @hilti_import.save
        format.html { redirect_to hilti_import_url(@hilti_import), notice: "Hilti import was successfully created." }
        format.json { render :show, status: :created, location: @hilti_import }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hilti_import.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hilti_imports/1 or /hilti_imports/1.json
  def update
    respond_to do |format|
      if @hilti_import.update(hilti_import_params)
        format.html { redirect_to hilti_import_url(@hilti_import), notice: "Hilti import was successfully updated." }
        format.json { render :show, status: :ok, location: @hilti_import }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hilti_import.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hilti_imports/1 or /hilti_imports/1.json
  def destroy
    @hilti_import.destroy!

    respond_to do |format|
      format.html { redirect_to hilti_imports_url, notice: "Hilti import was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hilti_import
      @hilti_import = HiltiImport.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hilti_import_params
      params.require(:hilti_import).permit(:label, :archive, :import_project_id)
    end
end
