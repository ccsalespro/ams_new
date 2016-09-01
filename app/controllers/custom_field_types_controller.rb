class CustomFieldTypesController < ApplicationController
  before_action :set_custom_field_type, only: [:show, :edit, :update, :destroy]

  # GET /custom_field_types
  # GET /custom_field_types.json
  def index
    @custom_field_types = CustomFieldType.all
  end

  # GET /custom_field_types/1
  # GET /custom_field_types/1.json
  def show
  end

  # GET /custom_field_types/new
  def new
    @custom_field_type = CustomFieldType.new
  end

  # GET /custom_field_types/1/edit
  def edit
  end

  # POST /custom_field_types
  # POST /custom_field_types.json
  def create
    @custom_field_type = CustomFieldType.new(custom_field_type_params)

    respond_to do |format|
      if @custom_field_type.save
        format.html { redirect_to @custom_field_type, notice: 'Custom field type was successfully created.' }
        format.json { render :show, status: :created, location: @custom_field_type }
      else
        format.html { render :new }
        format.json { render json: @custom_field_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /custom_field_types/1
  # PATCH/PUT /custom_field_types/1.json
  def update
    respond_to do |format|
      if @custom_field_type.update(custom_field_type_params)
        format.html { redirect_to @custom_field_type, notice: 'Custom field type was successfully updated.' }
        format.json { render :show, status: :ok, location: @custom_field_type }
      else
        format.html { render :edit }
        format.json { render json: @custom_field_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /custom_field_types/1
  # DELETE /custom_field_types/1.json
  def destroy
    @custom_field_type.destroy
    respond_to do |format|
      format.html { redirect_to custom_field_types_url, notice: 'Custom field type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_custom_field_type
      @custom_field_type = CustomFieldType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def custom_field_type_params
      params.require(:custom_field_type).permit(:name, :description)
    end
end
