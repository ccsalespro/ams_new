class InttableitemsController < ApplicationController
  before_action :set_inttableitem, only: [:show, :edit, :update, :destroy]

  # GET /inttableitems
  # GET /inttableitems.json
  def index
    @inttableitems = Inttableitem.all
  end

  # GET /inttableitems/1
  # GET /inttableitems/1.json
  def show
  end

  # GET /inttableitems/new
  def new
    @inttableitem = Inttableitem.new
  end

  # GET /inttableitems/1/edit
  def edit
  end

  # POST /inttableitems
  # POST /inttableitems.json
  def create
    @inttableitem = Inttableitem.new(inttableitem_params)

    respond_to do |format|
      if @inttableitem.save
        format.html { redirect_to @inttableitem, notice: 'Inttableitem was successfully created.' }
        format.json { render :show, status: :created, location: @inttableitem }
      else
        format.html { render :new }
        format.json { render json: @inttableitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inttableitems/1
  # PATCH/PUT /inttableitems/1.json
  def update
    respond_to do |format|
      if @inttableitem.update(inttableitem_params)
        format.html { redirect_to @inttableitem, notice: 'Inttableitem was successfully updated.' }
        format.json { render :show, status: :ok, location: @inttableitem }
      else
        format.html { render :edit }
        format.json { render json: @inttableitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inttableitems/1
  # DELETE /inttableitems/1.json
  def destroy
    @inttableitem.destroy
    respond_to do |format|
      format.html { redirect_to inttableitems_url, notice: 'Inttableitem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inttableitem
      @inttableitem = Inttableitem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inttableitem_params
      params.require(:inttableitem).permit(:inttype_id, :statement_id, :transactions, :volume)
    end
end
