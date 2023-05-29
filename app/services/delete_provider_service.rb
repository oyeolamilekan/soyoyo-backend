class DeleteProviderService < ApplicationService
    attr_reader :business_slug, :provider_id

    def initialize(business_slug, provider_id)
        @business_slug = business_slug
        @provider_id = provider_id
    end

    def call
        provider = Provider.joins(:business).find_by(id: @provider_id, businesses: { slug: @business_slug }).destroy!
    end
end