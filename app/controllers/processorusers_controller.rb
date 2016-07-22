class ProcessorusersController < ApplicationController
  before_action :set_processoruser, only: [:show, :edit, :update, :destroy]

  # GET /processorusers
  # GET /processorusers.json
  def index
    @processorusers = Processoruser.all
  end

  # GET /processorusers/1
  # GET /processorusers/1.json
  def show
  end

  # GET /processorusers/new
  def new
    @processoruser = Processoruser.new
  end

  # GET /processorusers/1/edit
  def edit
  end

  # POST /processorusers
  # POST /processorusers.json
  def create
    @processoruser = Processoruser.new(processoruser_params)

    respond_to do |format|
      if @processoruser.save
        format.html { redirect_to @processoruser, notice: 'Processoruser was successfully created.' }
        format.json { render :show, status: :created, location: @processoruser }
      else
        format.html { render :new }
        format.json { render json: @processoruser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /processorusers/1
  # PATCH/PUT /processorusers/1.json
  def update
    respond_to do |format|
      if @processoruser.update(processoruser_params)
        format.html { redirect_to @processoruser, notice: 'Processoruser was successfully updated.' }
        format.json { render :show, status: :ok, location: @processoruser }
      else
        format.html { render :edit }
        format.json { render json: @processoruser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /processorusers/1
  # DELETE /processorusers/1.json
  def destroy
    @processoruser.destroy
    respond_to do |format|
      format.html { redirect_to processorusers_url, notice: 'Processoruser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_processoruser
      @processoruser = Processoruser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def processoruser_params
      params.require(:processoruser).permit(:processor_id, :user_id, :agentnumber)
    end
end
