class InttypesController < ApplicationController
  before_action :set_inttype, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin
  # GET /inttypes
  # GET /inttypes.json
  def index
    @inttypes = Inttype.all
  end

  def import
    Inttype.import(params[:file])
    redirect_to inttypes_path, notice: "Interchange Types Imported"
  end

  # GET /inttypes/1
  # GET /inttypes/1.json
  def show
  end

  # GET /inttypes/new
  def new
    @inttype = Inttype.new
  end

  # GET /inttypes/1/edit
  def edit
  end

  # POST /inttypes
  # POST /inttypes.json
  def create
    @inttype = Inttype.new(inttype_params)

    respond_to do |format|
      if @inttype.save
        format.html { redirect_to inttypes_path, notice: 'Inttype was successfully created.' }
        format.json { render :show, status: :created, location: @inttype }
      else
        format.html { render :new }
        format.json { render json: @inttype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inttypes/1
  # PATCH/PUT /inttypes/1.json
  def update
    respond_to do |format|
      if @inttype.update(inttype_params)
        format.html { redirect_to inttypes_path, notice: 'Inttype was successfully updated.' }
        format.json { render :show, status: :ok, location: @inttype }
      else
        format.html { render :edit }
        format.json { render json: @inttype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inttypes/1
  # DELETE /inttypes/1.json
  def destroy
    @inttype.destroy
    respond_to do |format|
      format.html { redirect_to inttypes_url, notice: 'Inttype was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inttype
      @inttype = Inttype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inttype_params
      params.require(:inttype).permit(:card_type, :description, :full_description, :percent, :per_item, :max, :B2B, :B2C, :Keyed, :Swiped, :ecomm, :CVV, :Zip, :Address, :Name, :Downgrade, :biz_type, :max_ticket, :regulated, :TE, :credit, :debit, :prepaid)
    end
end
