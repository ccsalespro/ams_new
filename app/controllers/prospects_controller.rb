class ProspectsController < ApplicationController
  before_action :set_prospect, only: [:show, :edit, :update, :destroy]
  before_action :load_description, only: [:new]
  before_action :authenticate_user!
  before_action :require_subscribed


  # GET /prospects
  # GET /prospects.json
  def index
    @search = current_user.prospects.search(params[:q])
    @prospects = @search.result
    if @search.result.none?
      @searchnone = "No Results"
    end
  end

  # GET /prospects/1
  # GET /prospects/1.json
  def show
  end

  # GET /prospects/new
  def new
    @prospect = current_user.prospects.build
    @prospect.description_id = @description.id
    @prospect.description_primary = @description.business_type_primary
    @prospect.description_secondary = @description.business_type_secondary
    @prospect.amex_business_type = @description.amex_business_type
  end

  # GET /prospects/1/edit
  def edit
    @sorted_tasks = @prospect.tasks.sort_by{ |t| t.finish_date }
    @completed_tasks = @sorted_tasks.select { |task| task.completed? == true }
    @uncompleted_tasks = @sorted_tasks.select { |task| task.completed? == false }
    @next_task =  @uncompleted_tasks.first
  end

  # POST /prospects
  # POST /prospects.json
  def create
    @prospect = current_user.prospects.build(prospect_params)

    respond_to do |format|
      if @prospect.save
        format.html { redirect_to new_prospect_statement_path(@prospect), notice: 'Prospect was successfully created.' }
        format.json { render :back, status: :created, location: @prospect }
      else
        format.html { render :new }
        format.json { render json: @prospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prospects/1
  # PATCH/PUT /prospects/1.json
  def update
    respond_to do |format|
      if @prospect.update(prospect_params)
        format.html { redirect_to :back, notice: 'Prospect was successfully updated.' }
        format.json { render :show, status: :ok, location: @prospect }
      else
        format.html { render :edit }
        format.json { render json: @prospect.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prospects/1
  # DELETE /prospects/1.json
  def destroy
    @prospect.destroy
    respond_to do |format|
      format.html { redirect_to prospects_url, notice: 'Prospect was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prospect
      @prospect = Prospect.find(params[:id])
    end

    def load_description
      @description = Description.find(params[:description_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prospect_params
      params.require(:prospect).permit(:business_name, :description_id, :description_secondary, :description_primary, :amex_business_type, :contact_name, :phone, :email, :source_type, :stage_id)
    end
end
