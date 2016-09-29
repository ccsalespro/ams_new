class ProgramsController < ApplicationController


  before_action :set_program, only: [:show, :edit, :update, :destroy, :clone]
  before_filter :load_processor, except: [:index]
  before_action :authenticate_user!
  before_action :require_program_ownership, only: [:edit, :destroy]
  before_action :require_edit_permission, only: [:edit, :destroy]
  
  # GET /programs
  # GET /programs.json
  def index
    @programusers = Programuser.where(user_id: current_user.id)
    if @programusers.first == nil
      @sorted_programs = []
    else
    @programs = []
    @programusers.each do |programuser|
      @program = Program.find_by_id(programuser.program_id)
      @programs << @program
    end
    @sorted_programs = @programs.sort do |x, y|
      if x[:personal] == y[:personal]
        0
      elsif x[:personal] == true
        -1
      elsif x[:personal] == false
        1
      end
    end
  end
  end

  def import
    Program.import(params[:file])
    redirect_to processor_programs_path, notice: "Programs imported"
  end

  def clone
    @clone = @processor.programs.new
    @clone.name = "#{@program.name} || CLONE"
    @clone.min_volume = @program.min_volume
    @clone.max_volume = @program.max_volume
    @clone.up_front_bonus = @program.up_front_bonus
    @clone.residual_split = @program.residual_split
    @clone.min_bp_mark_up = @program.min_bp_mark_up
    @clone.min_per_item_fee = @program.min_per_item_fee
    @clone.cost_structure = @program.cost_structure
    @clone.terminal_type = @program.terminal_type
    @clone.terminal_ownership_type = @program.terminal_ownership_type
    @clone.system_id = @program.system_id
    @clone.per_item_cost = @program.per_item_cost
    @clone.bin_sponsorship = @program.bin_sponsorship
    @clone.visa_access_per_item = @program.visa_access_per_item
    @clone.visa_access_percentage = @program.visa_access_percentage
    @clone.mc_access_per_item = @program.mc_access_per_item
    @clone.mc_access_percentage = @program.mc_access_percentage
    @clone.disc_access_per_item = @program.disc_access_per_item
    @clone.disc_access_percentage = @program.disc_access_percentage
    @clone.min_monthly_fees = @program.min_monthly_fees
    @clone.monthly_fee_costs = @program.monthly_fee_costs
    @clone.monthly_pci_fee = @program.monthly_pci_fee
    @clone.monthly_pci_cost = @program.monthly_pci_cost
    @clone.annual_pci_fee = @program.annual_pci_fee
    @clone.annual_pci_cost = @program.annual_pci_cost
    @clone.min_pin_debit_per_item_fee = @program.min_pin_debit_per_item_fee
    @clone.pin_debit_per_item_cost = @program.pin_debit_per_item_cost
    @clone.monthly_debit_fee_cost = @program.monthly_debit_fee_cost
    @clone.min_monthly_debit_fee = @program.min_monthly_debit_fee
    @clone.next_day_funding_monthly_cost = @program.next_day_funding_monthly_cost
    @clone.next_day_funding_monthly_fee = @program.next_day_funding_monthly_fee
    @clone.amex_per_item_cost = @program.amex_per_item_cost
    @clone.min_amex_per_item_fee = @program.min_amex_per_item_fee
    @clone.amex_bp_cost = @program.amex_bp_cost
    @clone.min_amex_bp_fee = @program.min_amex_bp_fee
    @clone.application_fee_cost = @program.application_fee_cost
    @clone.min_application_fee = @program.min_application_fee
    @clone.min_per_batch_fee = @program.min_per_batch_fee
    @clone.per_batch_cost = @program.per_batch_cost
    @clone.vs_check_card_per_item = @program.vs_check_card_per_item
    @clone.vs_check_card_access_percentage = @program.vs_check_card_access_percentage
    @clone.personal = true
    @clone.save

    @programuser = Programuser.new
    @programuser.user_id = current_user.id
    @programuser.program_id = @clone.id
    @programuser.edit_permission = true
    @programuser.save

    @custom_fields = CustomField.where(program_id: @program.id)
    @custom_fields.each do |c|
      @custom_field = @clone.custom_fields.new
      @custom_field.name = c.name
      @custom_field.custom_field_type_id = c.custom_field_type_id
      @custom_field.amount = c.amount
      @custom_field.cost = c.cost 
      @custom_field.save
    end

    redirect_to edit_processor_program_path(@processor, @clone)
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
    
    no_nils(@program)

    respond_to do |format|
      if @program.save
        format.html { redirect_to processor_programs_path(@processor, @program), notice: 'Program was successfully created.' }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
    @programuser = Programuser.new
    @programuser.user_id = current_user.id
    @programuser.program_id = @program.id
    @programuser.edit_permission = true
    @programuser.save
  end

  # PATCH/PUT /programs/1
  # PATCH/PUT /programs/1.json
  def update

    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to processor_programs_path(@processor, @program), notice: 'Program was successfully updated.' }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end

    no_nils(@program)
    @program.save

  end

  # DELETE /programs/1
  # DELETE /programs/1.json
  def destroy
    @program.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def no_nils(program)
      if program.max_volume == nil
        program.max_volume = 0
      end

      if program.min_volume == nil
        program.min_volume = 0
      end

      if program.up_front_bonus == nil
        program.up_front_bonus = 0
      end

      if program.residual_split == nil
        program.residual_split = 0
      end

      if program.min_per_item_fee == nil
        program.min_per_item_fee = 0
      end

      if program.per_item_cost == nil
        program.per_item_cost = 0
      end

      if program.min_bp_mark_up == nil
        program.min_bp_mark_up = 0
      end

      if program.bin_sponsorship == nil
        program..bin_sponsorship = 0
      end

      if program.min_monthly_fees == nil
        program.min_monthly_fees = 0
      end

      if program.monthly_fee_costs == nil
        program.monthly_fee_costs = 0
      end

      if program.monthly_pci_fee == nil
        program.monthly_pci_fee = 0
      end

      if program.monthly_pci_cost == nil
        program.monthly_pci_cost = 0
      end

      if program.min_monthly_debit_fee == nil
        program.min_monthly_debit_fee = 0
      end

      if program.monthly_debit_fee_cost == nil
        program.monthly_debit_fee_cost = 0
      end

      if program.annual_pci_fee == nil
        program.annual_pci_fee = 0
      end

      if program.annual_pci_cost == nil
        program.annual_pci_cost = 0
      end

      if program.vs_check_card_per_item == nil
        program.vs_check_card_per_item = 0
      end

      if program.vs_check_card_access_percentage == nil
        program.vs_check_card_access_percentage = 0
      end

      if program.visa_access_per_item == nil
        program.visa_access_per_item = 0
      end

      if program.visa_access_percentage == nil
        program.visa_access_percentage = 0
      end

      if program.mc_access_per_item == nil
        program.mc_access_per_item = 0
      end

      if program.mc_access_percentage == nil
        program.mc_access_percentage = 0
      end

      if program.disc_access_percentage == nil
        program.disc_access_percentage = 0
      end

      if program.disc_access_per_item == nil
        program.disc_access_per_item = 0
      end

      if program.min_per_batch_fee == nil
        program.min_per_batch_fee = 0
      end

      if program.per_batch_cost == nil
        program.per_batch_cost = 0
      end

      if program.min_pin_debit_per_item_fee == nil
        program.min_pin_debit_per_item_fee = 0
      end

      if program.pin_debit_per_item_cost == nil
        program.pin_debit_per_item_cost = 0
      end

      if program.next_day_funding_monthly_fee == nil
        program.next_day_funding_monthly_fee = 0
      end

      if program.next_day_funding_monthly_cost == nil
        program.next_day_funding_monthly_cost = 0
      end

      if program.min_amex_per_item_fee == nil
        program.min_amex_per_item_fee = 0
      end

      if program.amex_per_item_cost == nil
        program.amex_per_item_cost = 0
      end

      if program.min_amex_bp_fee == nil
        program.min_amex_bp_fee = 0
      end

      if program.amex_bp_cost == nil
        program.amex_bp_cost = 0
      end

      if program.min_application_fee == nil
        program.min_application_fee = 0
      end

      if program.application_fee_cost == nil
        program.application_fee_cost = 0
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
      params.require(:program).permit(:vs_check_card_access_percentage, :vs_check_card_per_item, :processor_id, :min_per_batch_fee, :per_batch_cost, :name, :min_volume, :max_volume, :up_front_bonus, :residual_split, :min_bp_mark_up, :min_per_item_fee, :cost_structure, :terminal_type, :terminal_ownership_type, :per_item_cost, :bin_sponsorship, :visa_access_per_item, :visa_access_percentage, :mc_access_per_item, :mc_access_percentage, :disc_access_per_item, :disc_access_percentage, :min_monthly_fees, :monthly_fee_costs, :monthly_pci_fee, :monthly_pci_cost, :annual_pci_fee, :annual_pci_cost, :min_pin_debit_per_item_fee, :pin_debit_per_item_cost, :monthly_debit_fee_cost, :min_monthly_debit_fee, :next_day_funding_monthly_cost, :next_day_funding_monthly_fee, :amex_per_item_cost, :min_amex_per_item_fee, :amex_bp_cost, :min_amex_bp_fee, :application_fee_cost, :min_application_fee, :system_id)
    end

    def require_program_ownership
      if @program.personal == false && current_user.admin != true
        redirect_to programs_path, :notice => 'Not Authorized To Edit Program!'
      end
    end

    def require_edit_permission
      if current_user.admin != true
        @programuser = Programuser.where(user_id: current_user.id).where(program_id: @program.id).last
        unless @programuser.edit_permission?
          redirect_to programs_path, notice: "You are not authorized to edit this program - Contact Administrator"
        end
      end
  end
end