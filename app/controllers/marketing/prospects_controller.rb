module Marketing
  class ProspectsController < BaseController
    def new
      @description = Description.find(params[:description_id])
      @prospect = Prospect.new
      @prospect.stage = Stage.first
      @prospect.business_name = "#{'Marketing Lead: ' + Date.today.strftime("%b, %d")} #{'at: ' + Time.now.strftime("%l%P")}"

      if user_signed_in?
        @prospect.user = current_user
      else
        @prospect.user_id = 1
      end

      @prospect.description_id = @description.id
      @prospect.description_primary = @description.business_type_primary
      @prospect.description_secondary = @description.business_type_secondary
      @prospect.amex_business_type = @description.amex_business_type
      @prospect.save
      redirect_to new_marketing_prospect_statement_path(@prospect)
    end
  end
end
