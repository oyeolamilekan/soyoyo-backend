class GenerateApiKeyService < ApplicationService
    attr_reader :business_slug
    
    def initialize(business_slug)
        @business_slug = business_slug
    end

    def call
        api_key_obj = ApiKey.regenerate_api_keys(@business_slug)
        return api_key_obj
    end
end