class DescriptionsController < ApplicationController
  before_action :set_description, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_subscribed
  before_action :require_admin, only: [:show, :edit, :update, :destroy, :index, :new]
  
  # GET /descriptions
  # GET /descriptions.json

  def index
    @descriptions = Description.all
    respond_to do |format|
      format.html
      format.csv { render text: @descriptions.to_csv }
    end
  end

  def import
    Description.import(params[:file])
    redirect_to descriptions_path, notice: "Descriptions imported"
  end

  
  def choose
      @search = Description.search(params[:q])
      @descriptions = @search.result
      if @search.result.none?
      @searchnone = "No Results"
    end
  end

  # GET /descriptions/1
  # GET /descriptions/1.json
  def show
  end

  # GET /descriptions/new
  def new
    @description = Description.new
  end

  # GET /descriptions/1/edit
  def edit
  end

  # POST /descriptions
  # POST /descriptions.json
  def create
    @description = Description.new(description_params)

    respond_to do |format|
      if @description.save
        format.html { redirect_to @description, notice: 'Description was successfully created.' }
        format.json { render :show, status: :created, location: @description }
      else
        format.html { render :new }
        format.json { render json: @description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /descriptions/1
  # PATCH/PUT /descriptions/1.json
  def update
    respond_to do |format|
      if @description.update(description_params)
        format.html { redirect_to @description, notice: 'Description was successfully updated.' }
        format.json { render :show, status: :ok, location: @description }
      else
        format.html { render :edit }
        format.json { render json: @description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descriptions/1
  # DELETE /descriptions/1.json
  def destroy
    @description.destroy
    respond_to do |format|
      format.html { redirect_to descriptions_url, notice: 'Description was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_description
      @description = Description.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def description_params
      params.require(:description).permit(:business_type_primary, :amex_business_type, :business_type_secondary, :avg_ticket)
    end
end
