class ProgramusersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_programuser, except: [:index, :new, :create]
  # GET /programusers
  # GET /programusers.json
  def index
    @programusers = Programuser.all
  end

  # GET /programusers/1
  # GET /programusers/1.json
  def show
  end

  # GET /programusers/new
  def new
    @programuser = Programuser.new
  end

  # GET /programusers/1/edit
  def edit
  end

def toggle_edit_permission
     if @programuser.edit_permission == true
      @programuser.edit_permission = false
     else
      @programuser.edit_permission = true
     end
   @programuser.save

   if @programuser.edit_permission == true
     redirect_to :back, notice: 'Edit Permission Given'
    else
     redirect_to :back, notice: 'Edit Permission Removed'
    end
end

  # POST /programusers
  # POST /programusers.json
  def create
    @programuser = Programuser.new(programuser_params)

    if Programuser.exists?(user_id: @programuser.user_id, program_id: @programuser.program_id)
      redirect_to :back, notice: 'Program Already Assigned To User!'
    else

    respond_to do |format|
      if @programuser.save
        format.html { redirect_to :back, notice: 'Program Was Successfully Assigned To User' }
        format.json { render :show, status: :created, location: @programuser }
      else
        format.html { render :new }
        format.json { render json: @programuser.errors, status: :unprocessable_entity }
      end
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
    program = Program.find(@programuser.program_id)
    Comparison.where(program_id: program).destroy_all
    Programuser.where(program_id: program).destroy_all
    CustomField.where(program_id: program).destroy_all
    program.delete

    respond_to do |format|
      format.html { redirect_to programs_path, notice: 'program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_programuser
      @programuser = Programuser.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def programuser_params
      params.require(:programuser).permit(:user_id, :program_id, :edit_permission)
    end
end
