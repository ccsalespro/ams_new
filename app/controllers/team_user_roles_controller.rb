class TeamUserRolesController < ApplicationController
  before_action :set_team_user_role, only: [:show, :edit, :update, :destroy]
  before_action :require_admin

  # GET /team_user_roles
  # GET /team_user_roles.json
  def index
    @team_user_roles = TeamUserRole.all
  end

  # GET /team_user_roles/1
  # GET /team_user_roles/1.json
  def show
  end

  # GET /team_user_roles/new
  def new
    @team_user_role = TeamUserRole.new
  end

  # GET /team_user_roles/1/edit
  def edit
  end

  # POST /team_user_roles
  # POST /team_user_roles.json
  def create
    @team_user_role = TeamUserRole.new(team_user_role_params)

    respond_to do |format|
      if @team_user_role.save
        format.html { redirect_to @team_user_role, notice: 'Team user role was successfully created.' }
        format.json { render :show, status: :created, location: @team_user_role }
      else
        format.html { render :new }
        format.json { render json: @team_user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_user_roles/1
  # PATCH/PUT /team_user_roles/1.json
  def update
    respond_to do |format|
      if @team_user_role.update(team_user_role_params)
        format.html { redirect_to @team_user_role, notice: 'Team user role was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_user_role }
      else
        format.html { render :edit }
        format.json { render json: @team_user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_user_roles/1
  # DELETE /team_user_roles/1.json
  def destroy
    @team_user_role.destroy
    respond_to do |format|
      format.html { redirect_to team_user_roles_url, notice: 'Team user role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_user_role
      @team_user_role = TeamUserRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_user_role_params
      params.require(:team_user_role).permit(:name, :description, :bill_to)
    end
end
