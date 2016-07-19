class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    @notes = Note.all
  end


   def create
    @prospect = Prospect.find(params[:prospect_id])
    @note = @prospect.notes.new(note_params)
    @note.user = current_user

    respond_to do |format|
      if @note.save
        format.html { redirect_to :back, notice: 'Note Added' }
        format.js { render :layout => false }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
end

  
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Note was successfully destroyed.' }
      format.js { render :layout => false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:prospect_id, :body, :user_id)
    end
end
