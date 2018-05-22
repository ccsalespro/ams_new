module Marketing
  class ProspectsController < BaseController
    def edit
      @description = Description.find(params[:description_id])
      @prospect = Prospect.find(params[:id])
      @prospect.description_id = @description.id
      @prospect.description_primary = @description.business_type_primary
      @prospect.description_secondary = @description.business_type_secondary
      @prospect.amex_business_type = @description.amex_business_type
      @prospect.save
      redirect_to new_marketing_prospect_statement_path(@prospect)
    end
  end
end
