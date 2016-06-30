class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]
  before_filter :load_processor
  before_action :authenticate_user!
  
  # GET /programs
  # GET /programs.json
  def index
    @programs = @processor.programs.all
  end

  def import
    Program.import(params[:file])
    redirect_to processor_programs_path, notice: "Programs imported"
  end

  # GET /programs/1
  # GET /programs/1.json
  def show
  end

  # GET /programs/new
  def new
    @program = @processor.programs.new
  end

  # GET /programs/1/edit
  def edit
  end

  # POST /programs
  # POST /programs.json
  def create
    @program = @processor.programs.new(program_params)

    respond_to do |format|
      if @program.save
        format.html { redirect_to [@processor, @program], notice: 'Program was successfully created.' }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to [@processor, @program], notice: 'Program was successfully updated.' }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program.destroy
    respond_to do |format|
      format.html { redirect_to processor_programs_path(@processor), notice: 'Program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def load_processor
      @processor = Processor.find(params[:processor_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def program_params
      params.require(:program).permit(:processor_id, :min_per_batch_fee, :per_batch_cost, :name, :min_volume, :max_volume, :up_front_bonus, :residual_split, :min_bp_mark_up, :min_per_item_fee, :cost_structure, :terminal_type, :terminal_ownership_type, :per_item_cost, :bin_sponsorship, :visa_access_per_item, :visa_access_percentage, :mc_access_per_item, :mc_access_percentage, :disc_access_per_item, :disc_access_percentage, :min_monthly_fees, :monthly_fee_costs, :monthly_pci_fee, :monthly_pci_cost, :annual_pci_fee, :annual_pci_cost, :min_pin_debit_per_item_fee, :pin_debit_per_item_cost, :monthly_debit_fee_cost, :min_monthly_debit_fee, :next_day_funding_monthly_cost, :next_day_funding_monthly_fee, :amex_per_item_cost, :min_amex_per_item_fee, :amex_bp_cost, :min_amex_bp_fee, :application_fee_cost, :min_application_fee)
    end
end
