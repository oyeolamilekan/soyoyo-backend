class DeleteProviderService < ApplicationService
    attr_reader :business_slug, :provider_id

    def initialize(business_slug, provider_id)
        @business_slug = business_slug
        @provider_id = provider_id
    end

    def call
        puts @provider_id
        puts @business_slug
        puts "fkkkf/fff"
        provider = Provider.joins(:business).find_by(id: @provider_id, businesses: { slug: @business_slug }).destroy
    end
end