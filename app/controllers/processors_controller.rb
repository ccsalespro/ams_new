class ProcessorsController < ApplicationController
  before_action :set_processor, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin

  # GET /processors
  # GET /processors.json

  # GET /processors/1
  # GET /processors/1.json
  def show
  end

  # GET /processors/new
  def new
    @processor = Processor.new
    @processors = Processor.all.where(personal: false).uniq
    @private_processors = current_user.processors.where(personal: true).uniq
  end

  # GET /processors/1/edit
  def edit
  end

  # POST /processors
  # POST /processors.json
  def create
    @processor = Processor.new(processor_params)

    respond_to do |format|
      if @processor.save
        format.html { redirect_to new_processor_path, notice: 'Processor was successfully created.' }
        format.json { render :show, status: :created, location: @processor }
      else
        format.html { render :new }
        format.json { render json: @processor.errors, status: :unprocessable_entity }
      end
    end

    @processoruser = Processoruser.new
    @processoruser.user_id = current_user.id
    @processoruser.processor_id = @processor.id
    @processoruser.save
  end

  # PATCH/PUT /processors/1
  # PATCH/PUT /processors/1.json
  def update
    respond_to do |format|
      if @processor.update(processor_params)
        format.html { redirect_to @processor, notice: 'Processor was successfully updated.' }
        format.json { render :show, status: :ok, location: @processor }
      else
        format.html { render :edit }
        format.json { render json: @processor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /processors/1
  # DELETE /processors/1.json
  def destroy
    @processor.destroy
    respond_to do |format|
      format.html { redirect_to new_processor_path, notice: 'Processor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_processor
      @processor = Processor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def processor_params
      params.require(:processor).permit(:name)
    end
end
