class ProgramsController < ApplicationController
  before_action :set_program, only: [:show, :edit, :update, :destroy]
  before_filter :load_processor

  # GET /programs
  # GET /programs.json
  def index
    @programs = @processor.programs.all
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
      params.require(:program).permit(:name, :per_item_cost, :min_per_item_fee, :processor_id)
    end
end
