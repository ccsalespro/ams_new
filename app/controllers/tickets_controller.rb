class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin
  

   def create
    @user = User.find(params[:user_id])
    @ticket = @user.tickets.new(ticket_params)
    @ticket.user = @user

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to :back, notice: 'Note Added' }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
end

  
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Ticket was successfully destroyed.' }
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:body, :user_id, :admin_user_id)
    end
end
