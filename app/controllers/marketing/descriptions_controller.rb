module Marketing
  class DescriptionsController < BaseController
    def quote
      @retail_descriptions = Description.where(business_type_primary: "Retail")
      @restaurant_descriptions = Description.where(business_type_primary: "Restaurant")
      @auto_descriptions = Description.where(business_type_primary: "Auto")
      @service_descriptions = Description.where(business_type_primary: ["Services", "Salon"])
      @descriptions = Description.all
    end
  end
end
