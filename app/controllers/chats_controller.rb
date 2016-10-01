class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_subscribed

   def create
    @team = Team.find(params[:team_id])
    @chat = @team.chats.new(chat_params)
    @chat.user_id = current_user.id

    respond_to do |format|
      if @chat.save
        format.html { redirect_to :back }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
end

  
  def destroy
    @chat.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = chat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chat_params
      params.require(:chat).permit(:team_id, :message, :user_id)
    end
end
