class IntcalcitemsController < ApplicationController
  before_action :set_intcalcitem, only: [:show, :edit, :update, :destroy]

  # GET /intcalcitems
  # GET /intcalcitems.json
  def index
    @intcalcitems = Intcalcitem.all
  end

  # GET /intcalcitems/1
  # GET /intcalcitems/1.json
  def show
  end

  # GET /intcalcitems/new
  def new
    @intcalcitem = Intcalcitem.new
  end

  # GET /intcalcitems/1/edit
  def edit
  end

  # POST /intcalcitems
  # POST /intcalcitems.json
  def create
    @intcalcitem = Intcalcitem.new(intcalcitem_params)

    respond_to do |format|
      if @intcalcitem.save
        format.html { redirect_to @intcalcitem, notice: 'Intcalcitem was successfully created.' }
        format.json { render :show, status: :created, location: @intcalcitem }
      else
        format.html { render :new }
        format.json { render json: @intcalcitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /intcalcitems/1
  # PATCH/PUT /intcalcitems/1.json
  def update
    respond_to do |format|
      if @intcalcitem.update(intcalcitem_params)
        format.html { redirect_to @intcalcitem, notice: 'Intcalcitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @intcalcitem }
      else
        format.html { render :edit }
        format.json { render json: @intcalcitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /intcalcitems/1
  # DELETE /intcalcitems/1.json
  def destroy
    @intcalcitem.destroy
    respond_to do |format|
      format.html { redirect_to intcalcitems_url, notice: 'Intcalcitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_intcalcitem
      @intcalcitem = Intcalcitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def intcalcitem_params
      params.require(:intcalcitem).permit(:inttype_id, :transactions, :volume)
    end
end
