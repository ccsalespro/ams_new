class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :require_team_edit_priveledges, only: [:edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @team_users = TeamUser.where(user_id: current_user.id)
    @teams = []
    @team_users.each do |u|
      team = Team.find_by_id(u.team_id)
      @teams << team
    end
    @teams
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
    define_team_user
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
    define_team_user
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :team_type_id)
    end

    def define_team_user
      @team_user = if TeamUser.where(user_id: current_user.id).where(team_id: @team.id).empty?
                     TeamUser.new
                   else
                    TeamUser.where(user_id: current_user.id).where(team_id: @team.id).first
                   end
      @team_user.user_id = current_user.id 
      @team_user.team_id = @team.id

      case @team.team_type.description
        when "Processor"
          @team_user.team_user_role_id = 7 
        when "ISO"
          @team_user.team_user_role_id = 2
        when "Affiliate"
          @team_user.team_user_role_id = 8
        when "Recruiter"
          @team_user.team_user_role_id = 4
        when "Admin"
          @team_user.team_user_role_id = 9
      end 
      @team_user.save
  end

  def require_team_edit_priveledges
    @team_user = TeamUser.where(user_id: current_user.id).where(team_id: @team.id).first

    case @team.team_type.description
      when "Processor"
        unless @team_user.team_user_role.name == "Employee"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "ISO"
        unless @team_user.team_user_role.name == "Owner"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "Affiliate"
        unless @team_user.team_user_role.name == "Reseller"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "Recruiter"
        unless @team_user.team_user_role.name == "Recruiter"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
      when "Admin"
        unless @team_user.team_user_role.name == "IQAdmin"
          redirect_to teams_path, notice: "You Are Not Authorized to Edit This Team"
        end
    end 
  end
end
