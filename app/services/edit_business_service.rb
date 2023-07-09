class EditBusinessService < ApplicationService
    attr_reader :params, :business
    
    def initialize(params, business)
        @params = params
        @business = business
    end

    def call
        business_obj = Business.find_by(@params)
        raise StandardError, 'Business does not exists.' unless business_obj.present?
        business_obj.update(@business)
        business_obj
    end
end