class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  # GET /merchants
  # GET /merchants.json
  def index
    @merchants = Merchant.all
    respond_to do |format|
      format.html
      format.csv { render text: @merchants.to_csv }
    end
  end

  def import
    Merchant.import(params[:file])
    redirect_to merchants_path, notice: "Merchants imported"
  end

  # GET /merchants/1
  # GET /merchants/1.json
  def show
  end

  # GET /merchants/new
  def new
    @merchant = Merchant.new
  end

  # GET /merchants/1/edit
  def edit
  end

  # POST /merchants
  # POST /merchants.json
  def create
    @merchant = Merchant.new(merchant_params)

    respond_to do |format|
      if @merchant.save
        format.html { redirect_to @merchant, notice: 'Merchant was successfully created.' }
        format.json { render :show, status: :created, location: @merchant }
      else
        format.html { render :new }
        format.json { render json: @merchant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /merchants/1
  # PATCH/PUT /merchants/1.json
  def update
    respond_to do |format|
      if @merchant.update(merchant_params)
        format.html { redirect_to @merchant, notice: 'Merchant was successfully updated.' }
        format.json { render :show, status: :ok, location: @merchant }
      else
        format.html { render :edit }
        format.json { render json: @merchant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /merchants/1
  # DELETE /merchants/1.json
  def destroy
    @merchant.destroy
    respond_to do |format|
      format.html { redirect_to merchants_url, notice: 'Merchant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_merchant
      @merchant = Merchant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def merchant_params
      params.require(:merchant).permit(:business_type_primary, :business_type_secondary, :sic_1, :sic_2, :sic_3, :interchange_percentage, :avg_ticket, :amex_percentage, :amex_per_item, :check_card_percentage, :amex_vol, :check_card_vol, :mc_vol, :vs_vol, :disc_vol, :debit_vol, :total_transactions, :amex_transactions, :interchange_fees, :total_fees, :debit_transactions, :debit_network_fees, :ebt_vol, :ebt_fees)
    end
end
