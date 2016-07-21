class IntitemsController < ApplicationController
  before_action :set_intitem, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin
  # GET /intitems
  # GET /intitems.json
  def index
    @intitems = Intitem.all
  end

  def import
    Intitem.import(params[:file])
    redirect_to inttypes_path, notice: "Interchange Items imported"
  end

  # GET /intitems/1
  # GET /intitems/1.json
  def show
  end

  # GET /intitems/new
  def new
    @intitem = Intitem.new
  end

  # GET /intitems/1/edit
  def edit
  end

  # POST /intitems
  # POST /intitems.json
  def create
    @intitem = Intitem.new(intitem_params)

    respond_to do |format|
      if @intitem.save
        format.html { redirect_to @intitem, notice: 'Intitem was successfully created.' }
        format.json { render :show, status: :created, location: @intitem }
      else
        format.html { render :new }
        format.json { render json: @intitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intitems/1
  # PATCH/PUT /intitems/1.json
  def update
    respond_to do |format|
      if @intitem.update(intitem_params)
        format.html { redirect_to @intitem, notice: 'Intitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @intitem }
      else
        format.html { render :edit }
        format.json { render json: @intitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intitems/1
  # DELETE /intitems/1.json
  def destroy
    @intitem.destroy
    respond_to do |format|
      format.html { redirect_to intitems_url, notice: 'Intitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intitem
      @intitem = Intitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intitem_params
      params.require(:intitem).permit(:merchant_id, :inttype_id, :mid, :month, :card_type, :transactions, :volume)
    end
end
