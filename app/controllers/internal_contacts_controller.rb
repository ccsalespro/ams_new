class InternalContactsController < ApplicationController
  before_action :set_internal_contact, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:index]

  # GET /internal_contacts
  # GET /internal_contacts.json
  def index
    @internal_contacts = InternalContact.all
    @internal_contacts.each do |message|
      if message.read == false
        message.read = true
        message.save
      end
    end
  end


  # GET /internal_contacts/new
  def new
    @internal_contact = InternalContact.new
  end

  # POST /internal_contacts
  # POST /internal_contacts.json
  def create
    @internal_contact = InternalContact.new(internal_contact_params)

    respond_to do |format|
      if @internal_contact.save
        format.html { redirect_to :back, notice: 'Message Sent' }
        format.json { render :show, status: :created, location: @internal_contact }
      else
        format.html { render :new }
        format.json { render json: @internal_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /internal_contacts/1
  # DELETE /internal_contacts/1.json
  def destroy
    @internal_contact.destroy
    respond_to do |format|
      format.html { redirect_to internal_contacts_url, notice: 'Contact Message Was Destroyed' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal_contact
      @internal_contact = InternalContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def internal_contact_params
      params.require(:internal_contact).permit(:full_name, :phone_number, :email_address, :message)
    end
end
