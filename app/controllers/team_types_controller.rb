class TeamTypesController < ApplicationController
  before_action :set_team_type, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  # GET /team_types
  # GET /team_types.json
  def index
    @team_types = TeamType.all
  end

  # GET /team_types/1
  # GET /team_types/1.json
  def show
  end

  # GET /team_types/new
  def new
    @team_type = TeamType.new
  end

  # GET /team_types/1/edit
  def edit
  end

  # POST /team_types
  # POST /team_types.json
  def create
    @team_type = TeamType.new(team_type_params)

    respond_to do |format|
      if @team_type.save
        format.html { redirect_to @team_type, notice: 'Team type was successfully created.' }
        format.json { render :show, status: :created, location: @team_type }
      else
        format.html { render :new }
        format.json { render json: @team_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_types/1
  # PATCH/PUT /team_types/1.json
  def update
    respond_to do |format|
      if @team_type.update(team_type_params)
        format.html { redirect_to @team_type, notice: 'Team type was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_type }
      else
        format.html { render :edit }
        format.json { render json: @team_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_types/1
  # DELETE /team_types/1.json
  def destroy
    @team_type.destroy
    respond_to do |format|
      format.html { redirect_to team_types_url, notice: 'Team type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_type
      @team_type = TeamType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_type_params
      params.require(:team_type).permit(:description)
    end
end
