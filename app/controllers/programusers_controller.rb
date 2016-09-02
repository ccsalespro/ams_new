class ProgramusersController < ApplicationController
  before_action :require_admin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /programusers
  # GET /programusers.json
  def index
    @programusers = programuser.all
  end

  # GET /programusers/1
  # GET /programusers/1.json
  def show
  end

  # GET /programusers/new
  def new
    @programuser = programuser.new
  end

  # GET /programusers/1/edit
  def edit
  end

  def destroy_programuser
    @programuser = Programuser.where(user_id: current_user.id).where(program_id: params[:id]).first
    @programuser.destroy
    redirect_to programs_path, notice: 'Program Was Successfully Deleted'
  end

  # POST /programusers
  # POST /programusers.json
  def create
    @programuser = programuser.new(programuser_params)

    respond_to do |format|
      if @programuser.save
        format.html { redirect_to @programuser, notice: 'programuser was successfully created.' }
        format.json { render :show, status: :created, location: @programuser }
      else
        format.html { render :new }
        format.json { render json: @programuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programusers/1
  # PATCH/PUT /programusers/1.json
  def update
    respond_to do |format|
      if @programuser.update(programuser_params)
        format.html { redirect_to @programuser, notice: 'programuser was successfully updated.' }
        format.json { render :show, status: :ok, location: @programuser }
      else
        format.html { render :edit }
        format.json { render json: @programuser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programusers/1
  # DELETE /programusers/1.json
  def destroy
    @programuser.destroy
    respond_to do |format|
      format.html { redirect_to programusers_url, notice: 'programuser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_programuser
      @programuser = programuser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def programuser_params
      params.require(:programuser).permit(:inttype_id, :statement_id, :transactions, :volume)
    end
end
