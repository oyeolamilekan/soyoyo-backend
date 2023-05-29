class GetBusinessService < ApplicationService
    attr_reader :business_params
    
    def initialize(business_params)
        @business_params = business_params
    end

    def call
        business = Business.find_by(@business_params)
        return business
    end
end