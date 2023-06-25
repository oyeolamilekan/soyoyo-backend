class GetProvidersService < ApplicationService
    attr_reader :business_slug
    
    def initialize(business_slug)
        @business_slug = business_slug
    end

    def call
        providers = Provider.joins(:business).where(businesses: { slug: @business_slug })
        return providers
    end
end