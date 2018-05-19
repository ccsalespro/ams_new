module Marketing
  class DescriptionsController < BaseController
    def choose
      @descriptions = Description.all
    end
  end
end
