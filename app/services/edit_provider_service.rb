class EditProviderService < ApplicationService
    attr_reader :provider_title, :business_slug, :public_key

    def initialize(provider_title, business_slug, public_key)
        @provider_title = provider_title
        @business_slug = business_slug
        @public_key = public_key
    end

    def call
        provider = Provider.joins(:business).find_by(title: @provider_title, businesses: { slug: @business_slug })
        raise StandardError, 'Could not find provider.' unless provider.present?
        provider.update(public_key: @public_key)
    end
end