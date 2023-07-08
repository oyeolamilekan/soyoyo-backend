class CreateApiKeysService < ApplicationService
    attr_reader :business_id

    def initialize(business_id)
        @business_id = business_id
    end

    def call
        api_key = ApiKey.create!(business_id: @business_id)
        return api_key
    end
end